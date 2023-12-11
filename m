Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA480D406
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbjLKRg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344748AbjLKRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:36:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A367C7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:36:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CFCC433C7;
        Mon, 11 Dec 2023 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316193;
        bh=Ako3lvIvEUfiqGQJq4GqRqTsaTMhVesj9bhTZOv+avA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cv1+xrqXoHFbWdUJLTpczJTYJa5136QAg8p6zLoBASeDwSQPJEGvfqHhPkQJxwAsj
         6BZCcIbYNQq+GeQVeC8BWl3x+b2c9DBWhroFbuc6z8B2F0+aZMJWp54PixQoKCDFGt
         jgJdPnLwggbppAuLR4+FzYF9wW5JVFrPbAxWtF6SUCOydC3D6/h+geJ6K7D5WKIPm3
         8UACbWFhw/YQlJ8eO9XeJko/Mdo0d5j6xeTtN+y0fKPEJpwirXmqHAawBrRHO5df/v
         GLcstuYk1daow0GukEskHUbPRdWxB8LF0oILCP8MCoOGBqY2KwnKRFO1RujcWxhzxg
         6wCX045ThnJsw==
Date:   Mon, 11 Dec 2023 17:36:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100
 LPASS RX
Message-ID: <a210dd57-a22f-41ab-8e3b-93fa1fd03a0c@sirena.org.uk>
References: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
 <20231211-cardstock-elevator-3e19f9d41ac2@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n42/ISRIigQDPDMF"
Content-Disposition: inline
In-Reply-To: <20231211-cardstock-elevator-3e19f9d41ac2@spud>
X-Cookie: Better dead than mellow.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n42/ISRIigQDPDMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 05:29:50PM +0000, Conor Dooley wrote:
> On Mon, Dec 11, 2023 at 01:31:01PM +0100, Krzysztof Kozlowski wrote:
> > Add bindings for Qualcomm X1E80100 SoC Low Power Audio SubSystem (LPASS)
> > RX macro codec, which looks like compatible with earlier SM8550.

> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> I wish you'd send cover letters when you send series of trivial patches
> like this that could be acked in one go.

In general any patch series should have at least a brief cover letter,
it makes everything work much better.

--n42/ISRIigQDPDMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3SJkACgkQJNaLcl1U
h9DAmwf9FAyBzWGolz41aTQV/iYxTZfK4ZqEsyyThB9fYsQrPLVGYOw5PHpUTeul
0d88h6YldHkaT+pffLxlmSlq0D8H2XmOSsSjKE0/8RCLSZL4V5MgOksiQzQxsBUV
Sbrz2hfDZqYhg5bis2VHpjwrfdXjY7lrpOtGwomGqaecaAm7swTu3tyL7Eh23dBF
w4MpjYr20bJnbt7qwi32NxvzETYnVm0JFaX1biUkJtHowZpi55Z+9XydwmRWlvJZ
w6G3K+++zd8Wo+ViR1pYaHWOxlvLB0RXP0kEZtIiCeNAiaSOlIDcGMVwkyVGcPfF
FBb4ujCnVVxe6GlilQfyEDfJThkmJA==
=8Yu8
-----END PGP SIGNATURE-----

--n42/ISRIigQDPDMF--
