Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77B7B5B51
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbjJBT1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbjJBT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:27:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01715DC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:27:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7611C433C7;
        Mon,  2 Oct 2023 19:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696274828;
        bh=M3xDfvFGJJ/XkEcT9JbDKrkZISYSg+CslZeqm002CB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/DPb7cvsilLk1Me6VqMIkpZXQltZmNhVfkH1ND/tlty7MKbI65nGb/5L7x8FiLEZ
         trFegEA7SOIy2qJ2oUDGbKZn2UsnPB61coGpOzRaEiWVmXmLQdpPCAwM3JZuSoqxhg
         1Gxxb1eUlUjWkPZ5PvaUap7PyuWWBh5P6lu4V4obRTi2XfJn1Bv4By4q2fjJ/3IMzZ
         nDo+EWy9TDxxRRlVxema8XVH9+Z8SG5yMfFDia+5BUYEDbpikZKgCod/Paepuucp1Q
         2aucm/MFeL8GA6tz0bg5dLULejYY8gvl7LFbm/XtcJKequQEcDmJGtiAXwxJBZsGnN
         Rnp/Z/IfcKQRw==
Date:   Mon, 2 Oct 2023 20:27:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: Convert PXA1928 USB/HSIC PHY to DT
 schema
Message-ID: <20231002-lividly-cameo-d8f8b3a0d8e5@spud>
References: <20231001-pxa1928-usb-yaml-v1-1-9309a8c0c03f@skole.hr>
 <20231002143619.GA1651295-robh@kernel.org>
 <4849448.GXAFRqVoOG@radijator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JfifZB+kbj7ENI+C"
Content-Disposition: inline
In-Reply-To: <4849448.GXAFRqVoOG@radijator>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JfifZB+kbj7ENI+C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 04:55:08PM +0200, Duje Mihanovi=C4=87 wrote:
> On Monday, October 2, 2023 4:36:19 PM CEST Rob Herring wrote:
> > On Sun, Oct 01, 2023 at 03:05:43PM +0200, Duje Mihanovi=C4=87 wrote:
> > > +maintainers:
> > > +  - devicetree@vger.kernel.org
> >=20
> > No, should be someone with hardware or familar with it. I added this,
> > but no longer have h/w or documentation. IMO, it should probably be
> > removed.
>=20
> My samsung,coreprimevelte's PXA1908 uses this PHY, is it fine if I add my=
self=20
> there instead of the devicetree list?

I would say, please do add yourself!

--JfifZB+kbj7ENI+C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRsZiAAKCRB4tDGHoIJi
0pYRAP4h8UzkWugenlTljc1mHc6xiEIv6TodIDuceuZiVozMiwD/eAfn8S2aLBVn
M4fP3xq30F7v6BjCzJ3ft3dU0b/Lhwo=
=Zns+
-----END PGP SIGNATURE-----

--JfifZB+kbj7ENI+C--
