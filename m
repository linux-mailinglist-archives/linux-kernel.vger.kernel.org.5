Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843567BBE36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjJFR6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjJFR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:58:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80AD10D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:58:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C8CC433CA;
        Fri,  6 Oct 2023 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696615104;
        bh=wLekRGvd4kg2nVJYGE/aJQU67LExRJ4hntpmaO1oovE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKwIEItboRF6SItins8qFFnAAHtJklFR5vwfGJBRx2rKUTzl3BHrx3rxMkMkFKK/E
         7X+65dsua7+xJO87b54GFPnfvjZlefBDuQffwPzyT6Br5SYwSULl0PY54xBibllY0E
         JPNTBFIrIONspktehpjrrN2meMx3NbqTbzdxvt4BGDabjObcNFJJ3pgHA1nrqls7TC
         9q4r67H7o7uPhprQK0JLzfT5JI7nBlMKHpO56gp3WfYjzs+Z++tJwGMSTfOBQcMrmL
         jezZ167hGG0HcU2cR8taZneLuJKuCSBBfmpVP1imDxE1zjy8n6GZD1agAeFl/6uMqK
         EXOeKaDp08RLA==
Received: (nullmailer pid 72249 invoked by uid 1000);
        Fri, 06 Oct 2023 17:58:22 -0000
Date:   Fri, 6 Oct 2023 12:58:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Da Xue <da.xue@libretech.co>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add libretech
 cottonwood support
Message-ID: <169661510170.72194.9933533745144399283.robh@kernel.org>
References: <20231006103500.2015183-1-jbrunet@baylibre.com>
 <20231006103500.2015183-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006103500.2015183-2-jbrunet@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Oct 2023 12:34:59 +0200, Jerome Brunet wrote:
> Add compatibles for the Libretech cottonwood board family
> 
> Co-developed-by: Da Xue <da.xue@libretech.co>
> Signed-off-by: Da Xue <da.xue@libretech.co>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

