Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE78118F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjLMQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378978AbjLMQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:15:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3477F13A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:15:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F673C433C7;
        Wed, 13 Dec 2023 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702484150;
        bh=ZqEBUHrDEyZ8vkQ44qaY7mZTN79QNnv4TScFFLk5+vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Of14jwS8A1sZTdZkNDvtnyx9NBrsJmwu737MeFhswh8XXSiBr2ZlfgLkFFrPcrseI
         KBcM5cBSsQI+UcM3ZZiTaTN7Z+MQcE0kNpaiv/87K0My92Xf6wn+fJ9tCyX0BvTMEK
         4PBODvEfrqMvCS7WA1uhWfnGh4AxbqVfm8Uk/2qq4+9TKTTHIk/F18X554kqp+4ouc
         tPoBmbP+R3AfoxCxjYfcY6zRfw/WnD8pW4s4gXIz2s2oUgpI4s1VJaJ3djMcjeSYDL
         NuClBDQsLOdksM5b9yt/M59A5QY4GBocz0L1+lEPL+NqscUSFnFbawvcoAr43/KY5D
         fF5lXh+JjohfA==
Date:   Wed, 13 Dec 2023 16:15:46 +0000
From:   Conor Dooley <conor@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Message-ID: <20231213-jogging-void-79416ce73560@spud>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
 <20231213-ad7380-mainline-v2-2-cd32150d84a3@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B/2uj1twGd2QJ9G1"
Content-Disposition: inline
In-Reply-To: <20231213-ad7380-mainline-v2-2-cd32150d84a3@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B/2uj1twGd2QJ9G1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 05:21:19AM -0600, David Lechner wrote:
> This adds a binding specification for the Analog Devices Inc. AD7380
> family of ADCs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Having read the patchset in the correct order, this patch now
seems fine to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--B/2uj1twGd2QJ9G1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnYsgAKCRB4tDGHoIJi
0tpwAQCxYBiFQmCqom4mwWDb0e1I7dm/40px79kV8XltCtJiWwD+MU13YNO77cic
ua/woQGNvZ8oc4ZH3wH9XYPxa+n7Ogg=
=nkrt
-----END PGP SIGNATURE-----

--B/2uj1twGd2QJ9G1--
