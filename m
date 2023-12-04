Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00D1803A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344676AbjLDQ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjLDQ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:27:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B5195
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:27:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FBCC433C7;
        Mon,  4 Dec 2023 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701707237;
        bh=IQD+6ShDGEkoKp0dcPe5eVwpPIHahHs+5LKTlUYoWRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZAz5lrXF0MsmUxmKEUnEnrSGsVQrfEXwAPB2a1IgDjow5aNH8jFQttH/k+IbYv/k
         BGw8SpLhg9MSOhaf+iz3WFFkFQm72fz7FVFMZuA4KSAzS44CRZ22vyAf92SBCcBD+y
         cvRpFvkexiT3G/4gZ/reQh4isO78WL5jzBiCRoz2qC7Vt57pA3xgvfJLTvfZOhmMsi
         ZGi3fQG1OgGbzh3RqXlTri40RwB/Nme1Dkx50n0GP9E5ChoSK235RQT766IVsGEYG7
         WoEoqdjZ49zI3IrDicthfNo/e6Qpop4jSZ86zNk0oh6vSwgzxZqIXPJny9W1W8R+BI
         AhPRVa/B4zv4A==
Date:   Mon, 4 Dec 2023 16:27:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: qcom,sm8250: Add X1E80100 sound
 card
Message-ID: <20231204-salami-condone-f10b45e09828@spud>
References: <20231204100116.211898-1-krzysztof.kozlowski@linaro.org>
 <20231204100116.211898-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0c/XrDjxI3neAjwL"
Content-Disposition: inline
In-Reply-To: <20231204100116.211898-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0c/XrDjxI3neAjwL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 11:01:16AM +0100, Krzysztof Kozlowski wrote:
> Document bindings for the Qualcomm X1E80100 SoC sound card.  The
> bindings are the same as for other newer Qualcomm ADSP sound cards, thus
> keep them in existing qcom,sm8250.yaml file, even though Linux driver is
> separate.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--0c/XrDjxI3neAjwL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW393wAKCRB4tDGHoIJi
0uSaAP9t10prS2rDvL4Vjq/XD55wIkALOkf52ckItqXbEvt+rAD/YxHy9M/SpJrk
B2I6lPxE3KmwSmHKhi8KV/szOph/YQo=
=5fPr
-----END PGP SIGNATURE-----

--0c/XrDjxI3neAjwL--
