Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA557FC1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjK1R33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345317AbjK1R3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:29:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29265127
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:29:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875ECC433C7;
        Tue, 28 Nov 2023 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701192570;
        bh=4XvKlG/zv6MZy3Qi+1cyz4jVKinz5Rpd8AQHCJ5MZWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhIS7Awr6BRSM0qCLhFQKcG5NqrcWBrH+WnLFYMSXN00D0yANQf2FPU39R4pZoWtb
         XEVIgw5PGnKQDSVDxZxmW5a2n+zkS3nJ17kFTHbH+sqQ8opEtYf4t2t4RSlYlI2pZi
         gP0kNhoalFZ4jn2wXiy2U3QEar0nD+8Zz0Z5uVLx1tF3keYaGu8IEv2xe1xqCYRlJC
         YyK2ctqeirUNTrhk3OffUuTsyTv9iuo5juELUOMWHUPQPqidgiThtDfd5ttStxXDtu
         TCu3K4WLyDU/Am1wThc5Af9e4mRCEw/R+iNMwZFhZ1TrRxjJ/DroZPJWjT5g+pfISV
         AWcsn1escATwA==
Date:   Tue, 28 Nov 2023 17:29:25 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ante Knezic <ante.knezic@helmholz.de>, netdev@vger.kernel.org,
        woojung.huh@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v6 1/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231128-laxative-overjoyed-ab1b4b3656a1@spud>
References: <cover.1701091042.git.ante.knezic@helmholz.de>
 <7f1f89010743a06c4880fd224149ea495fe32512.1701091042.git.ante.knezic@helmholz.de>
 <20231128150203.GA3264915-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Eaz27h0FCLG7yZaF"
Content-Disposition: inline
In-Reply-To: <20231128150203.GA3264915-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Eaz27h0FCLG7yZaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 09:02:03AM -0600, Rob Herring wrote:
> On Mon, Nov 27, 2023 at 02:20:42PM +0100, Ante Knezic wrote:
> > Add documentation for selecting reference rmii clock on KSZ88X3 devices
> >=20
> > Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> > ---
> >  .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 38 ++++++++++++++=
+++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
>=20
> You forgot Conor's ack.

I think that's for the better, v5 and v6 look to have changed a decent
amount from what I acked in v4.

--Eaz27h0FCLG7yZaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWYjdQAKCRB4tDGHoIJi
0sM2AP0UONa6EAG1nkKSAMDOqDho9LhS8mI88zn0U4Zuvi53FQD+IEMco3IIebRn
qUJ59RjTmGnDpyXY+3khiNsf+D9M3QA=
=BBCx
-----END PGP SIGNATURE-----

--Eaz27h0FCLG7yZaF--
