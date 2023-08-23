Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128DE785BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbjHWPRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbjHWPRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:17:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD33910E4;
        Wed, 23 Aug 2023 08:17:13 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.46]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxDck-1porkp2gcC-00xdUe; Wed, 23 Aug 2023 17:14:59 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id B775B3F8F1; Wed, 23 Aug 2023 17:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1692803697; bh=uw6jwl4InPpa/04/fUgqKauP0mavunE1yZszeqLWIbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsK+4zBEHmVYOcLpRFHds+ahI17tfuWoeMAEyks4jBaHUn1qPP+D+iiuhXyfEMfl7
         ZpXi/TaKl8XjHLwmnEsmGcKFcPeB7rzArz7lgGiSIJTtRTT9FiveYEloWqIENXe6ZD
         SD0BNqudjnMEuVxfSX4e1g4TpyUhjwcnEgdrhABw=
Date:   Wed, 23 Aug 2023 17:14:56 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/1] scripts: Add add-maintainer.py
Message-ID: <ZOYicEP8D7kNGFin@fjasle.eu>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xsV49k7NnvCJSi4E"
Content-Disposition: inline
In-Reply-To: <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
Organization: AVM GmbH
X-Provags-ID: V03:K1:Bfka4+k2IyJ9YD9Dnj7y63cSZPlVRiT5x0e8TrmBXyXTqWTVaIF
 lowx+hV/1SY/19Lr0m+PwQogzTcQ4kajMpXXXvdDaTg3U0lgL1S+pj94GoWr/XPNKg7MaxT
 iNSj0I/x1p9tjrPvmDNqEvqB63AoXycdGmQA8i9u5Y8ZWus6iae168r1Zmx88obkIWR2Ue3
 Gq8Z6L3BTV4CdMz7ek0dg==
UI-OutboundReport: notjunk:1;M01:P0:D4AhMlUPFDY=;/AwzqFP/PuTfzj9fcXQQp3GEy5n
 V4lWynEQba+vse4ArYypbm/FqMVTzpdW0GxfgPLAhYHX/st5HCyAAKG8rYIas6wgSoft3gVsj
 BIvuKgVrOmA1CKGASPogy221bQ0fOMGsuduZTmzHFwuVZy6CRWjTkzEQz4THXzupaezawQrTb
 OJkJG6a9S0R0g3oCoolF1LzSqzDaOyj06V+Uf+KYTTwdpk0Yh02G7b8FSDa8r568M1KuAQx5y
 HC0vxNjFzcauwrThEovQaTFNcXvCObXOHCGXooQyHfStvO8WAkDepQpUUXDCDrLl8ogQ1AMkd
 NenVcw+cWwk3lsXMgB6mfu0jYE3OnuUWtEYobx9VtLVbuQk/Jjtm8GmocL4BYyyGEsiCKvO4E
 65O7pRDXCishwp2P7fIk211Cj6mshXu8Z6Zj0ybgBn9NKRraQ5MBQ1FXRcinrJOcF3otyhl72
 EbxMj1i8Nv/doVG4gcN9xesr/u6OXnY4538Ze2u9X/oKnFiBtPXvQ0PdPOsakuru4/EWworqx
 MsdQEESe9KFMNVkx3a7kgf84uh2KI5KjkSli8HnDypqFwlTV+bcHU5Hlc4eY/f3HSd8OJnLXg
 sjyjVHBIw30tGMOzNqXbPSdBR/pKO4ZBcCVOXx1ozNd3C8FnvyC9BRGKjH7qCq0C0gX+2xUGV
 qoYAflPpvcw93ViD1N1U1kc6tN0Og8iizxmF0h2YP6W9C5nPD5ROD6cDpJi2WE5SEcF1susJp
 A7rnoZ8XSUG3FO9H1hYV1LqG1ZJ0X3uXbYKaKctQ6iepNmrPh4j9cFiAQKEUY9dxNirmixSuJ
 0giv/ffrLpNikNW6Y/ut6ycValBHiRS4ZcAVPfDwBEyQ2YAgLRT0yc2cYTyAMd6AnAnsPJ5Lp
 CFX2GqYvJ9Q5QEw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xsV49k7NnvCJSi4E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guru,

thanks for your patch!  I really to appreciate the discussion about how to
lower the burden for first-time contributors; might you consider cc-ing
workflows@vger.kernel.org when sending v3?

Some additional thoughts to the feedback from Pavan:

On Thu, Aug 03, 2023 at 01:23:16AM -0700 Guru Das Srinagesh wrote:
> This script runs get_maintainer.py on a given patch file and adds its
> output to the patch file in place with the appropriate email headers
> "To: " or "Cc: " as the case may be. These new headers are added after
> the "From: " line in the patch.
>=20
> Currently, for a single patch, maintainers are added as "To: ", mailing
> lists and all other roles are addded as "Cc: ".

typo: addded -> added

>=20
> For a series of patches, however, a set-union scheme is employed in
> order to solve the all-too-common problem of sending subsets of a patch
> series to some lists, which results in important pieces of context such
> as the cover letter being dropped. This scheme is as follows:
> - Create set-union of all mailing lists corresponding to all patches and
>   add this to all patches as "Cc: "
> - Create set-union of all other roles corresponding to all patches and
>   add this to all patches as "Cc: "
> - Create set-union of all maintainers from all patches and use this to
>   do the following per patch:
>   - add only that specific patch's maintainers as "To: ", and
>   - the other maintainers from the other patches as "Cc: "
>=20
> Please note that patch files that don't have any "Maintainer"s
> explicitly listed in their `get_maintainer.pl` output will not have any
> "To: " entries added to them; developers are expected to manually make
> edits to the added entries in such cases to convert some "Cc: " entries
> to "To: " as desired.
>=20
> The script is quiet by default (only prints errors) and its verbosity
> can be adjusted via an optional parameter.

IMO, it would be nice to see which addresses are effectively added, e.g.
comparable to the output of git send-email.  Perhaps somehing like:

  $ scripts/add-maintainer.py *.patch
  0001-fixup-scripts-Add-add-maintainer.py.patch: Adding 'To: Guru Das Srin=
agesh <quic_gurus@quicinc.com>' (maintainer)
  0001-fixup-scripts-Add-add-maintainer.py.patch: Adding 'Cc: linux-kernel@=
vger.kernel.org' (list)

Perhaps verbosity should then be configurable.

>=20
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  scripts/add-maintainer.py | 113 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100755 scripts/add-maintainer.py
>=20
> diff --git a/scripts/add-maintainer.py b/scripts/add-maintainer.py
> new file mode 100755
> index 000000000000..b1682c2945f9
> --- /dev/null
> +++ b/scripts/add-maintainer.py
> @@ -0,0 +1,113 @@
> +#! /usr/bin/env python3
> +
> +import argparse
> +import logging
> +import os
> +import sys
> +import subprocess
> +import re
> +
> +def gather_maintainers_of_file(patch_file):
> +    all_entities_of_patch =3D dict()
> +
> +    # Run get_maintainer.pl on patch file
> +    logging.info("GET: Patch: {}".format(os.path.basename(patch_file)))
> +    cmd =3D ['scripts/get_maintainer.pl']
> +    cmd.extend([patch_file])
> +    p =3D subprocess.run(cmd, stdout=3Dsubprocess.PIPE, check=3DTrue)
> +    logging.debug("\n{}".format(p.stdout.decode()))
> +
> +    entries =3D p.stdout.decode().splitlines()
> +
> +    maintainers =3D []
> +    lists =3D []
> +    others =3D []
> +
> +    for entry in entries:
> +        entity =3D entry.split('(')[0].strip()
> +        if "maintainer" in entry:
> +            maintainers.append(entity)
> +        elif "list" in entry:
> +            lists.append(entity)
> +        else:
> +            others.append(entity)
> +
> +    all_entities_of_patch["maintainers"] =3D set(maintainers)
> +    all_entities_of_patch["lists"] =3D set(lists)
> +    all_entities_of_patch["others"] =3D set(others)
> +
> +    return all_entities_of_patch
> +
> +def add_maintainers_to_file(patch_file, entities_per_file, all_entities_=
union):
> +    logging.info("ADD: Patch: {}".format(os.path.basename(patch_file)))
> +
> +    # For each patch:
> +    # - Add all lists from all patches in series as Cc:
> +    # - Add all others from all patches in series as Cc:
> +    # - Add only maintainers of that patch as To:
> +    # - Add maintainers of other patches in series as Cc:
> +
> +    lists =3D list(all_entities_union["all_lists"])
> +    others =3D list(all_entities_union["all_others"])
> +    file_maintainers =3D all_entities_union["all_maintainers"].intersect=
ion(entities_per_file[os.path.basename(patch_file)].get("maintainers"))
> +    other_maintainers =3D all_entities_union["all_maintainers"].differen=
ce(entities_per_file[os.path.basename(patch_file)].get("maintainers"))
> +
> +    # Specify email headers appropriately
> +    cc_lists        =3D ["Cc: " + l for l in lists]
> +    cc_others       =3D ["Cc: " + o for o in others]
> +    to_maintainers  =3D ["To: " + m for m in file_maintainers]
> +    cc_maintainers  =3D ["Cc: " + om for om in other_maintainers]
> +    logging.debug("Cc Lists:\n{}".format('\n'.join(cc_lists)))
> +    logging.debug("Cc Others:\n{}".format('\n'.join(cc_others)))
> +    logging.debug("Cc Maintainers:\n{}".format('\n'.join(cc_maintainers)=
 or None))
> +    logging.debug("To Maintainers:\n{}\n".format('\n'.join(to_maintainer=
s) or None))
> +
> +    # Edit patch file in place to add maintainers
> +    with open(patch_file, "r") as pf:
> +        lines =3D pf.readlines()
> +
> +    from_line =3D [i for i, line in enumerate(lines) if re.search("From:=
 ", line)]

(extending Pavan comment on "From:" handling:)

Please use something like line.startswith("From:"), otherwise this catches =
any
"From: " in the whole file (that's the reason why add-maintainer.py fails on
this very patch).  Actually, you only want to search through the patch (mai=
l)
header block, not through the whole commit msg and the patch body.

> +    if len(from_line) > 1:
> +        logging.error("Only one From: line is allowed in a patch file")
> +        sys.exit(1)
> +
> +    next_line_after_from =3D from_line[0] + 1
> +
> +    for o in cc_others:
> +        lines.insert(next_line_after_from, o + "\n")
> +    for l in cc_lists:
> +        lines.insert(next_line_after_from, l + "\n")
> +    for om in cc_maintainers:
> +        lines.insert(next_line_after_from, om + "\n")
> +    for m in to_maintainers:
> +        lines.insert(next_line_after_from, m + "\n")
> +
> +    with open(patch_file, "w") as pf:
> +        pf.writelines(lines)
> +
> +def main():
> +    parser =3D argparse.ArgumentParser(description=3D'Add the respective=
 maintainers and mailing lists to patch files')
> +    parser.add_argument('patches', nargs=3D'*', help=3D"One or more patc=
h files")

nargs=3D'+' is one or more
nargs=3D'*' is zero, one or more

> +    parser.add_argument('--verbosity', choices=3D['debug', 'info', 'erro=
r'], default=3D'error', help=3D"Verbosity level of script output")
> +    args =3D parser.parse_args()
> +
> +    logging.basicConfig(level=3Dargs.verbosity.upper(), format=3D'%(leve=
lname)s: %(message)s')
> +
> +    entities_per_file =3D dict()
> +
> +    for patch in args.patches:
> +        entities_per_file[os.path.basename(patch)] =3D gather_maintainer=
s_of_file(patch)
> +
> +    all_entities_union =3D {"all_maintainers": set(), "all_lists": set()=
, "all_others": set()}
> +    for patch in args.patches:
> +        all_entities_union["all_maintainers"] =3D all_entities_union["al=
l_maintainers"].union(entities_per_file[os.path.basename(patch)].get("maint=
ainers"))
> +        all_entities_union["all_lists"] =3D all_entities_union["all_list=
s"].union(entities_per_file[os.path.basename(patch)].get("lists"))
> +        all_entities_union["all_others"] =3D all_entities_union["all_oth=
ers"].union(entities_per_file[os.path.basename(patch)].get("others"))
> +
> +    for patch in args.patches:
> +        add_maintainers_to_file(patch, entities_per_file, all_entities_u=
nion)
> +
> +    logging.info("Maintainers added to all patch files successfully")
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> --=20
> 2.40.0

While testing, I thought that adding addresses without filtering-out duplic=
ates
was odd; but as git-send-email does the unique filtering, it doesn't matter.

For my own workflow, I would rather prefer a git-send-email wrapper, simili=
ar
to the shell alias Krzysztof shared (but I like 'b4' even more).  Do you ha=
ve
some thoughts about a "smoother" workflow integration?  The best one I could
come up with is

    ln -sr scripts/add-maintainer.py .git/hooks/sendemail-validate
    git config --add --local sendemail.validate true
=2E

Kind regards,
Nicolas

--xsV49k7NnvCJSi4E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTmIm8ACgkQB1IKcBYm
EmkwNg/8CcMVHUuXEzqpy1bpgqq0oFC/PPV+GYrZQsOYjwGpipm1PetQA2XM6o6p
yf8hiP0lGnX6rNR+TbvVi58xcU4xKklvOzQz9Daeom52IYhrF+o4JW/fj1hhV3OC
uj+MZVG7ARBq4hWwqVGBMTxZRyZzeNCuoxpaIxsrUlpV+FVH3VQ2/yrpd4Nmz66t
qbDVaKhEK423EHUUfRNa10ftYZAudrHFPqBcdUPO2KO2IRvcZXTmvPKrRlrczNlF
iLuoakbeVqzEOw+Qt8Lm1ntebPzwLbPoh9nYKIHq/1VPV2AzsmEaodoLHBqtIvax
EGpGuUZhISHjQm2Xiv6UJ1vySwjsZ66kxUYmrIRPokF366Qe+hrwkNrsdevrhRqA
H1XjBlZ8jrpQV0Y8nKSyovbESyx1dHl0CuNfsRbwioQt7CVPcZ735AT150CLaQrX
s5cZoJEZznEjqelL+8s783kvoK/7dpiPKUPW/h3vMd3Q9+4MrnN+LoDhva0UDMAe
hFHck8tqn4n0d71PvdwvACYVDVJUjjH3Fv9b1QiKqlEYMppFFDRnveX7wi2buIs3
DurabW1zNK6Jfor/p4RklpSB5q+pk20CQC5OnSPGiiQwocmV8sscJtRzkXo35I5K
AwXbO4lrigOWDXF4vMDHZ0W7uMeCp240AOD1qGvzXx4XdJFinVE=
=UxVS
-----END PGP SIGNATURE-----

--xsV49k7NnvCJSi4E--
