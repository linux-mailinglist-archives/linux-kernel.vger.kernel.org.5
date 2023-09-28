Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B146A7B2556
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjI1SeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1SeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:34:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC5BF;
        Thu, 28 Sep 2023 11:34:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C17FC433C8;
        Thu, 28 Sep 2023 18:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695926052;
        bh=2NJ2R290lFgn343l702zf8oxmfde2JDPKjH1749HjD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEf0EaEk9iRWOkL9jIAgNO3NJ385d8K64JccvOdU0+D/dVouoyDp99Up7/jY2XQlA
         CAczvIRwHJC8ewLX5eQQUI6bw1muPRk74UoBCfBwui6ZTm0P8xmYB+PMbZh+f36yof
         0BzWlgi6XtIgkiAPPjR3I9IoaFGJinCkkLFwVNdoG/xQosbNJxJJDC/qU2om/14RvB
         LJCxoD5g1Iy8HM1gVXTc553suizGbnMGNCu0Ll839tRyQI91qEEJgof5KboWC6CCaT
         4OUcT44DGLikc+cDahzgjElVYUinDMW+Ndg9buqkFQ8w8A9m3LrUQoxA9JhzxumnIf
         8JWwGdbQX9KvQ==
Received: (nullmailer pid 1033329 invoked by uid 1000);
        Thu, 28 Sep 2023 18:34:10 -0000
Date:   Thu, 28 Sep 2023 13:34:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lars@metafoo.de, robh+dt@kernel.org, bcousson@baylibre.com,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        tony@atomide.com, linux-iio@vger.kernel.org,
        jean-baptiste.maneyrol@tdk.com, linux-kernel@vger.kernel.org,
        chenhuiz@axis.com, andy.shevchenko@gmail.com, conor+dt@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
Message-ID: <169592604948.1033273.7825083218859073623.robh@kernel.org>
References: <20230927173245.2151083-1-andreas@kemnade.info>
 <20230927173245.2151083-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927173245.2151083-2-andreas@kemnade.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Sep 2023 19:32:43 +0200, Andreas Kemnade wrote:
> Add a level shifter flag as found in ancient platform data struct:
> level_shifter: 0: VLogic, 1: VDD
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

