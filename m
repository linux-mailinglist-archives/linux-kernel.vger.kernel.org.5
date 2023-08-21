Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B01783154
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHUTf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjHUTf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:35:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEBEC2;
        Mon, 21 Aug 2023 12:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F86661655;
        Mon, 21 Aug 2023 19:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E48C433C7;
        Mon, 21 Aug 2023 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692646554;
        bh=6nvf88h/azd3v0bjTiteggvDcPHSsOt1fAtYiRSBHQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhBSxm76Qe0lDhjYcMH6IlhwGqBRkBs5HmO4BQQzSu62vq4zbCcvMdsDkgbD9cD/N
         fgO8Uh4D2J85yJ5ggtCvO/AYBOZP9KoBrCNNIXOUlJTuCRYHsfH/hUf1O6qrsYHoKx
         pxN4U6786UxDZkF7JVoPZ2Sqs9h4nnIzmg4KFP1br6GuVeTymuXVEhs9ygPkytRAaA
         53tDFtKk0qSTErDP33f6+zbVeAuAd9jw54ybzYufgyI3p7AIO5bs/ZcymTod78l3Ln
         wHV+o8X99ojHHbvcX6/ja/Pz3MthVt1hqHZ10NoOvOs8KRhqZ1dJMOAW8owWeTmUP3
         hlhLb5yNZzgnQ==
Received: (nullmailer pid 2167604 invoked by uid 1000);
        Mon, 21 Aug 2023 19:35:51 -0000
Date:   Mon, 21 Aug 2023 14:35:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     u.kleine-koenig@pengutronix.de, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, Jonathan.Cameron@huawei.com,
        linux-arm-kernel@lists.infradead.org, festevam@gmail.com,
        linus.walleij@linaro.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        shawnguo@kernel.org, rydberg@bitmath.org
Subject: Re: [PATCH 2/4] dt-bindings: touchscreen: neonode,zforce: Use
 standard properties
Message-ID: <169264655104.2167546.8315190057155508875.robh@kernel.org>
References: <20230815182948.212575-1-andreas@kemnade.info>
 <20230815182948.212575-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815182948.212575-3-andreas@kemnade.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Aug 2023 20:29:46 +0200, Andreas Kemnade wrote:
> Enable touchscreen orientation to be specified by using standard
> properties.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../bindings/input/touchscreen/neonode,zforce.yaml  | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

