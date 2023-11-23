Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1A7F659A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKWRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWRiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:38:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D3189
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:38:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32238C433D9;
        Thu, 23 Nov 2023 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700761104;
        bh=Yw6Y36ErXAJIavqLBexXl3lguY2vTWpO+ADAlK9isC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3dFS4mk9+zqoMSDzNRYX4a7q0zN2SB+nJXO53+w3a+g9Hjmc5PF3JytQHH+okqDe
         OKdoDF2lSatcZdn4fOZom7H2C/OJ6jpgoWOYexLTXRt2iYpdU2kyt0OgJyECkY5EB3
         1QUubQpzlv5VJu/Tdqdtbk7+e/4PJAZzUU4b4Zo1cKPTnGJB/3SXrnPnEjLAlghs/3
         btsfc3dxxGMxsQLEJ8Pj7dG74en7eo7GTTGmP3tg7hxuTLWgfDErgFGy0MAZMOUa2K
         sE5bJRtTerrBgxq/PWfZSfFON6od6oWddYy9kxyonTBoAP4hiqt2BQz0CXLogFZAUx
         W3qlONMHoBSJQ==
Date:   Thu, 23 Nov 2023 17:38:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ASoC: codec: wcd-mbhc-v2: add support when connected
 behind an USB-C audio mux
Message-ID: <ZV+ODbskjFe5louc@finisterre.sirena.org.uk>
References: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
 <20231123-topic-sm8650-upstream-wcd939x-codec-v1-3-21d4ad9276de@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zYYvbpAWCNy9mneV"
Content-Disposition: inline
In-Reply-To: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-3-21d4ad9276de@linaro.org>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYYvbpAWCNy9mneV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 03:49:13PM +0100, Neil Armstrong wrote:

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(wcd_mbhc_typec_report_unplug);

ASoC is generally EXPORT_SYMBOL_GPL.

--zYYvbpAWCNy9mneV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVfjgwACgkQJNaLcl1U
h9Borgf/WCcOu17PlfQEP8LcwwF7WliMIbDFpt7Sn3t6UjtZ4dG8lxo/wdWm3/zC
9a4IqCgD7yJT+N6iGTEzfXw4G9ql6x0QKA3eJhLPlcDHPUhm7K0Hk0NJZUltNSve
FScbROkncl72dzXhp3xmED1Xx+S+9lcLgQBE+LS8cYH6ifUPIe2zY2PLdzw1XQT7
jajx1PGVE7trmzx9cymbbNAGbL2At5yqdR/biX3O6ckzY3kkNThWIwAdPedZdn/S
kr/daf4kTS0ciuGI2RdeI6ZxhXt+BDEeW3Nf2pOF1ezaSnPm89GeoufjrkE3uIQm
XvoszEBrtSkSv7oM0ASB2XyrRjkH1w==
=aPTl
-----END PGP SIGNATURE-----

--zYYvbpAWCNy9mneV--
