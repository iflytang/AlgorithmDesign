 OFPACT(MODIFY_FIELD,   ofpact_modify_field,  ofpact, "modify_field") \

/* OFPACT_MODIFY_FIELD.
 *
 * Used for OFPAT10_MODIFY_FIELD. */
struct ofpact_modify_field {
	struct ofpact ofpact;

	uint16_t field_id;
    uint16_t offset;
    uint16_t len_field;
    uint32_t increment;
};