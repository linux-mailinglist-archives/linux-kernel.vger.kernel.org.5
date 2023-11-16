Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B057EE300
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjKPOhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjKPOho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:37:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D51196
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:37:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46DDC433CA;
        Thu, 16 Nov 2023 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700145461;
        bh=al1iPQtTj5S8+kmJIvOjqSlIMqeFQE4WgzTUxwqsS4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XaiyQAw5H9nI4k/r2urZShY7clc73iJIc/DXXYT8AhI/6SizqYyXjQK1/1j+udscd
         VhjWXkjd/xYHXX1jFZUk3a4IQNxlhHuFQMZcUm6ArwRTzu6r+asT/CWBNOxUlqgaP1
         hCf4YXOH4bBANzDVW1IqkvbQVBjmF6UXGNxyFGfu4FjTocbFCkmm7TreO9LQVo6DoX
         uoMahCdT6WCxo3pjMQgmAYhcU29K4KVpvBpQM21n5BhnSJEZB6z2CUVKWZIto6u9s7
         Xw+yLq3P2mIGbQmW/pbzcyjTGlz7SpN6oc+9cLcrZpWmXiUmD8iUbENVU4IBV+RL/I
         deNS0dH2ecYMQ==
Date:   Thu, 16 Nov 2023 14:37:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        paul.kocialkowski@bootlin.com, dafna@fastmail.com,
        helen.koike@collabora.com, heiko@sntech.de,
        paul.elder@ideasonboard.com
Subject: Re: [PATCH] media: dt-bindings: media: rkisp1: Fix the port
 description for the parallel interface
Message-ID: <20231116-rigor-rectified-2edcf9461c05@squawk>
References: <20231115164407.99876-1-mehdi.djait@bootlin.com>
 <20231116005140.GB21041@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a5aVI6MThUXgtnrw"
Content-Disposition: inline
In-Reply-To: <20231116005140.GB21041@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a5aVI6MThUXgtnrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 02:51:40AM +0200, Laurent Pinchart wrote:
> On Wed, Nov 15, 2023 at 05:44:07PM +0100, Mehdi Djait wrote:
> > The bus-type belongs to the endpoint's properties and should therefore
> > be moved.
> >=20
> > Fixes: 6a0eaa25bf36 ("media: dt-bindings: media: rkisp1: Add port for p=
arallel interface")
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
>=20
> Good catch.
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--a5aVI6MThUXgtnrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVYpLgAKCRB4tDGHoIJi
0vPhAQCT1dp7os5Z5idwlawY+a9tjPvQ5f/v4/48A/rLXyU0/QD/b2SEgPCdTPuQ
k0UQJ631n1qR1zcC5ZkEkQx+SVoxug8=
=8ET4
-----END PGP SIGNATURE-----

--a5aVI6MThUXgtnrw--
