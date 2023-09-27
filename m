Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677267B0790
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjI0PCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjI0PCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:02:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2FB180
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:02:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF997C433C9;
        Wed, 27 Sep 2023 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695826936;
        bh=v88zOCD1MhIGQeCc3jhAbFP6+Xl8Qp4bcBaLIXlYoHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=li2FkjrzP0xhHOtiBTK0kKjzq5/aLpuFR/olw9c8iYl4Zes/44X4qkX9tIfBsdawy
         61CGLWNHi2zTMQudmS8oKaPk7crhiL/Eeqd3/G79SRDpNuHnX3/cvIBOydZD1Uy90r
         TpEEvRbKupoESiOWHyc+vrCKrWWjvwb7bPcFdYbTPSWOShcREzc7MFejYwcoSBctIN
         CttgPrBNLR/+v7pVU29J8tdQ9JwM41s5dmxDXfeSLA8vESHsgbqvx/dCJEvGob9sc+
         zHBpz9JSJVJ4aHsFIWSX83uF1xqRzO4jeqDo/zhvFQia8WZSeAHQHMQ0Xor4088I9m
         6CHUGn8NoGQFg==
Date:   Wed, 27 Sep 2023 16:02:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Julian Ribbeck <julian.ribbeck@gmx.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: sunxi: Add
 itead,iteaduino-plus-a20
Message-ID: <20230927-bobsled-flakily-35be559bf561@spud>
References: <e0e71b0c-086d-ce54-f4d3-6f594d8e5da6@linaro.org>
 <20230617205624.1178427-1-julian.ribbeck@gmx.de>
 <20230617205624.1178427-2-julian.ribbeck@gmx.de>
 <bba4acf9-23a4-d732-900b-944c4ddef08c@linaro.org>
 <CVTLLDPXFP5D.ANP0YTD5AD0P@x1-yoga-arch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vewLjc3G4WHYvVHE"
Content-Disposition: inline
In-Reply-To: <CVTLLDPXFP5D.ANP0YTD5AD0P@x1-yoga-arch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vewLjc3G4WHYvVHE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 11:38:35AM +0200, Julian Ribbeck wrote:

> On Sun Jun 18, 2023 at 10:00 AM CEST, Krzysztof Kozlowski wrote:
> > On 17/06/2023 22:55, Julian Ribbeck wrote:
> > > Add itead,iteaduino-plus-a20 bindings
> > >=20
> > > Signed-off-by: Julian Ribbeck <julian.ribbeck@gmx.de>
> > > ---
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> I'm not totally familiar with the process here, but it seems like my
> patch was kind of forgotten? What should I do now? Is anything still
> missing?

Usually what you would do is CC the maintainers of the sunxi platform,
and they would apply the patches, although you don't seem to have done so.
Sending another version with them on CC is a good idea. That means, send
both this and the dts patch as a series (with this patch as 1/2).

--vewLjc3G4WHYvVHE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRD9AAKCRB4tDGHoIJi
0tUwAPj8dKwhuDrKze7GIBqHnfYwTc4kvo7cVuRM2y0pgDJSAP9bBGugC7fpApLF
an0wcl06BaKXwGZP58hWbObMtNxCBg==
=wjk0
-----END PGP SIGNATURE-----

--vewLjc3G4WHYvVHE--
