Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ACA7B07E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjI0POJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjI0POH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:14:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4156F5;
        Wed, 27 Sep 2023 08:14:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B951C433C8;
        Wed, 27 Sep 2023 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827646;
        bh=HbLge+IqtNY+p0o0HkcYhLccrRTIut/WHIJmU8OpY9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvuDTD+f24lyPKAlKP8H52gPB5SNU0APFFJzAlOfxxIxccuGkctliCieHsAammxkX
         37gb6CnH7Zp8O71QVUs5YPpI3Jw5D8HvSjjKvdUHWgn2xzrPBg2VYNm/VP6Z1cjVJo
         4FshrszKlfDvLXcXMUqU/MkrfbBCQ4wVDmqV4zxn6kkFY+9ctYcnkf/FhFXkad+BAL
         0hHryhQ9fJ58Bg3lYLIVIvwVBc33XnS+QH/Lt5BuiMRDa1IIk0bEIYv0CK4SsHvhRN
         8vS8luOBcmoN53Q7eE7mVbhkvkivdkIDUtXbkbSbUrjoW8ln4rstYjoAdkfDoLqIRn
         qLxn7lckvoemw==
Date:   Wed, 27 Sep 2023 16:14:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: adi,ad7292: Fix
 additionalProperties on channel nodes
Message-ID: <20230927-dried-reproach-12643ec50ba8@spud>
References: <20230926164357.100325-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g3UEL9/D40dCAJR+"
Content-Disposition: inline
In-Reply-To: <20230926164357.100325-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3UEL9/D40dCAJR+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--g3UEL9/D40dCAJR+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRGuQAKCRB4tDGHoIJi
0sZTAP4n/sXBWsOhcUWvEj+Zs1EJiqwwnNvV4KU6WUEPNRv3XgD/bOjgffKIeG5U
UBwQSA1lJrYTQTUKuipbwkPU686dcww=
=ynZJ
-----END PGP SIGNATURE-----

--g3UEL9/D40dCAJR+--
