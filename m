Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB31C7D2E20
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjJWJX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjJWJXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:23:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452BBAF;
        Mon, 23 Oct 2023 02:23:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A67AC433C7;
        Mon, 23 Oct 2023 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698053001;
        bh=aZBFa7fN1EH0urSii1LHTdENO3pg0U4aosD5CcywGOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsdUSetCYsPxlm2mEo2erqrcSSEMIbJPN+mwquIMS5v0zBB/zF6vOthd+ohrOuVAZ
         UVU8ksImL8gz4CcLRlhjrMCeI/Vf2dsFqgU83vgk4pNmOc7UqFNyYyTW7pKzoOdp9i
         Y4vY6QJg0LyHMsDiraZt8HDlO2JNBvvene6Uegl9FK0uUL/hhd1/WzE5DRS6joh6Iv
         47DDn0lyl6SBWknnaeb4p/6fbIygzeyZrThucG0QudR/UeulSJsOBp2llQllpS5aTl
         Pp6NYW3mNjD0amOF2TrdevqGyAWAf6SDvINhvZGhQ6VW5Mtr1w5Djz0iJqMDQmohMQ
         uv3sSew7XVDkQ==
Date:   Mon, 23 Oct 2023 10:23:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com
Subject: Re: [PATCH v3 RESEND 01/13] riscv: errata: Rename defines for Andes
Message-ID: <20231023-splashing-dandy-1effebb9ec30@spud>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-2-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dr6k7xdk2Nj78Rm8"
Content-Disposition: inline
In-Reply-To: <20231023004100.2663486-2-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dr6k7xdk2Nj78Rm8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 08:40:48AM +0800, Yu Chien Peter Lin wrote:
> Using "ANDES" rather than "ANDESTECH" to unify the naming
> convention with directory, file names, Kconfig options
> and other definitions.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Dr6k7xdk2Nj78Rm8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTY7fgAKCRB4tDGHoIJi
0szrAQDpbVZqytSdG3WsXMLtVH5Uqmw9YxPlcM5oJY5NdKbzngEAsaz52IDy3Sk5
0HxrIcXgEJ5z+J2YeJShi5+5WFBDYQc=
=HAN/
-----END PGP SIGNATURE-----

--Dr6k7xdk2Nj78Rm8--
