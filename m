Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D767D2772
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjJWASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJWASL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:18:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DACCDB;
        Sun, 22 Oct 2023 17:18:09 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B9676606F85;
        Mon, 23 Oct 2023 01:18:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698020287;
        bh=4Z1XHTk+ALsRgwRr7R3lLjwa13S7I+K3DpeSPC4sFgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ek9yWICRyg8JotFltL9yj0hU1kfPisDHrOSSvs9hwB4mKx7HxH+5mLnMk0cqWE5AG
         +BJX61xnr8aqDOolSQD2u6f3gTBV+5vHpmrT41mxjjHdu3LE0ColLFoxGOXZpxuIYI
         uAAdQQYjgNC4vsuNynoDnA9rvqIrYrY22JPhBb8pDsfafcvduZnpVYn29rCty9CloZ
         JNs9/4AwMmMq1mTPSOMkXdAfluhBPOfuhQuCBVlOzNIJHl4GyXfyzT0s2youipjUk7
         /iyVJ+6r5dZw3WspwCSGgF8qW6GA5+VG8WD8DXzUTNyN/tWvxZy9PS+zg9EVCT04/E
         7AtO7LEjrKMAw==
Received: by mercury (Postfix, from userid 1000)
        id E8615106050E; Mon, 23 Oct 2023 02:18:03 +0200 (CEST)
Date:   Mon, 23 Oct 2023 02:18:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: add rk3588 compatible to
 rockchip,dwc3
Message-ID: <20231023001803.7fylnbv74zp2ynx7@mercury.elektranox.org>
References: <20231020150022.48725-1-sebastian.reichel@collabora.com>
 <20231020150022.48725-2-sebastian.reichel@collabora.com>
 <20231020-shudder-tackle-cc98a82f1cd0@spud>
 <20231020160329.uqgjjr6ubfrcqjkj@mercury.elektranox.org>
 <20231022214219.GA706888-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="efodancjhx3m5yv4"
Content-Disposition: inline
In-Reply-To: <20231022214219.GA706888-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--efodancjhx3m5yv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Sun, Oct 22, 2023 at 04:42:19PM -0500, Rob Herring wrote:
> On Fri, Oct 20, 2023 at 06:03:29PM +0200, Sebastian Reichel wrote:
> > On Fri, Oct 20, 2023 at 04:36:19PM +0100, Conor Dooley wrote:
> > > On Fri, Oct 20, 2023 at 04:11:40PM +0200, Sebastian Reichel wrote:
> > > > [...]
> > > > +allOf:
> > > > +  - $ref: snps,dwc3.yaml#
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: rockchip,rk3328-dwc3
> > > > +    then:
> > > > +      properties:
> > > > +        clocks:
> > > > +          minItems: 3
> > > > +          maxItems: 4
> > > > +        clock-names:
> > > > +          minItems: 3
> > > > +          items:
> > > > +            - const: ref_clk
> > > > +            - const: suspend_clk
> > > > +            - const: bus_clk
> > > > +            - const: grf_clk
> > >=20
> > > minItems for clocks and clock-names is already 3, is it not?
> >=20
> > Yes, but the following 'maxItems: 4' implicitly sets it to 4,
> > so I had to set it again. The same is true for clock-names -
> > providings new 'items:' effectively drops the "minItems: 3"
> > from the generic section.
>=20
> Are you sure? We don't add anything implicit in the if/then schemas.=20
> Could be a tool issue though.

I had this issue in the past. But just in case I also did a re-test
before sending my last mail and I did get a warning. So yes, I'm
quite sure :)

-- Sebastian

--efodancjhx3m5yv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmU1u7gACgkQ2O7X88g7
+ppiog//dTq13sn4IdxnxaJPIqoOT87S1/uSFXDk18+PMySQWvlRgvG6Go7ozL5k
TKjrhVcYad7SVuJZ+ngEdGkU7RlNui+ioKTwiurqWA1yGC2p6vNm5SCndv9onUPk
oiaFGoaY+qTlqInwSibs3pT9XrXVY4TXQxALndF48NxV4UyBfhRVeWSC246NYJr+
BZL0MFKTHdnshHNEDMoBpsVl0tp7kGjFZtbYUYpbTrzNNpb36aR4nGds/ovoqYOL
Yz2w2EHFvlEpvyTLuXy4UN+pgeayL0wLBG+uk3l4B7ikiO5Yi8GI7DKxRyV9bVvF
/z1jSj6dbaub0oYO9DR8e3a2k/Z2YZ7DffL8oPf8ZhaZGj6rxZHSzBV2ipt5wTwZ
5YyWQtWuxmka4PrJfFLxm3syheXWnwyUnvFAeuBM/hbp5TtdpIq0zcfVX/T9AcFt
PctvrZo4HLOxnwQoyd+lnTFrhw4VygC9akpUWHj+3KXzVCB80W/qX63DiLL0X7cq
Snx1KgXTHZ0AM0J5nCWK2ttN7/yU54kqwg2v/sSRp6iyY24kau9endcwi8v5pdIx
e2ci77l3IfIKpoKUgpsiKxQp6H2pQ6B2qwodlfcaphde1GDEdeCPplILEC1IsstQ
bXuYBy3niQdeh+F5W0YWbwQpQ2Ns030D6ZUWs4ft9Dqut2C/fgk=
=F+il
-----END PGP SIGNATURE-----

--efodancjhx3m5yv4--
