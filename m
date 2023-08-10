Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE70977829C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjHJVSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjHJVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EA130E9;
        Thu, 10 Aug 2023 14:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7F06668CF;
        Thu, 10 Aug 2023 21:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB97C433C8;
        Thu, 10 Aug 2023 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691702314;
        bh=bXauksbrzRIAzsLWLan2wzaQd8ocmpjaKkxYLxARuKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiWj/ngmviRpQtR+W6p+RCEXQJEVgJ1iAUpjp8ZcBZ4jBwswvDVQxyHaVq61/c3I9
         m4pewl7IH5Wh8VqMrCMSHTM1BS0ZNz9V/vNdvvnbRuOA3C9gmGisqkNezVYgF6XfBm
         UUSy33iHtqmnSHH3qgnMgn/xTc24+O0kpheMy1Ji3E8Yp5QXw4WH4pUhVAFaDgW9lT
         Gs86IbMYzbWED1UxFw3QZrdIFnTz8/aCEDpxLPplYVJLHd5/ZawcdKOufQG/YJ4Oqc
         aiiWIF84Ci5sfBfZCvl0sTpnZLNEPVltT3K97T6oilWhv8MFIHgbXqufsi5B+UAwO5
         z8MML+6p1FYkg==
Received: (nullmailer pid 1205465 invoked by uid 1000);
        Thu, 10 Aug 2023 21:18:32 -0000
Date:   Thu, 10 Aug 2023 15:18:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh+dt@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add ShenZhen New
 Display Co.
Message-ID: <169170231172.1205407.8593190423899846567.robh@kernel.org>
References: <20230810144116.855951-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144116.855951-1-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 16:41:14 +0200, Luca Ceresoli wrote:
> ShenZhen New Display Co., Limited is the manufacturer of the
> NDS040480800-V3 LCD panel according the datasheet.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v2: none
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

