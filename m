Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8A76BF0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjHAVNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHAVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:13:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5892C3;
        Tue,  1 Aug 2023 14:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54CBD61719;
        Tue,  1 Aug 2023 21:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537D1C433C7;
        Tue,  1 Aug 2023 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690924419;
        bh=1KxlmjVC+rn+4F9/RYKUFaZEGPNwwdoI6N+XeJAaM5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gacVFyW8XNlN5dEk5cVmSXiFcQajYz6pmrRbtMfj9lFfELvp/UHImqJbC10bPR+PM
         vUNZLwN5Z5qyhT+V0IebRlsGGV92D5mqQF7mN7eqyvleXYXj218NFORuoVE8RKxG5I
         URMWarh6S07Ky3cEyDHzrSsgIbdWlzhzBRTOXaN8yFJ6xXTrlcsoatjVs6FKNfKGuw
         eXuTSiuG1Lu/1TTBPw4Bkod/6gogHuwLGBKFm5EZPAHaNeuN01vbszb1ceKd7ldLOg
         5e72SsYc9w86LGQ/yGzl17Ha+BAkEGcpFy6KcApVjss49ZbwUP7cvN4fbWKb8OaUlC
         HeUUHqur/lkeQ==
Date:   Tue, 1 Aug 2023 22:13:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
Message-ID: <20230801-dividers-chooser-bd0df9b72d91@spud>
References: <20230801170015.40965-1-festevam@denx.de>
 <20230801-clobber-attempt-7033f92b3d08@spud>
 <8b0e048208220b2ae09eb1a3c52219b9@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kmr4w11r0COYDrE/"
Content-Disposition: inline
In-Reply-To: <8b0e048208220b2ae09eb1a3c52219b9@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kmr4w11r0COYDrE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 06:10:52PM -0300, Fabio Estevam wrote:
> On 01/08/2023 17:47, Conor Dooley wrote:
>=20
> > Removing it without re-adding it elsewhere does not seem right, since
> > there'll now be some undocumented compatibles in the tree, no?
>=20
> Currently, there is no ov5642 support in the kernel.

It is present in devicetrees.

> If someone adds the support for the ov5642 camera, then a specific binding
> will have to be created.
>=20
> I prefer to remove it from trivial-devices to avoid confusion.
>=20
> As is, it gives a false impression that ov5642 is supported and that it
> is a trivial device.

The latter only do I agree with.

--kmr4w11r0COYDrE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMl1fwAKCRB4tDGHoIJi
0tTCAP9t4aBdr2sp6QMHgkLG3v3WAHiXyvVodsp/wErbCL7QBAEAprGSVLEF0U+g
61Mt6YUtURwLIGSfRuzo+HqsFTWf6wU=
=S4Ow
-----END PGP SIGNATURE-----

--kmr4w11r0COYDrE/--
