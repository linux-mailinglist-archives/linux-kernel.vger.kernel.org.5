Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CBD7F696F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 00:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjKWW4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWW4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:56:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9603B10E6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:56:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D596C433C7;
        Thu, 23 Nov 2023 22:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700780218;
        bh=xrj+obBZs3qijThw6u7kIITase46Q1QURXGiZSMGFBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y1gYtJQtAsh/3wDkm1vHs4w6EFT+mCVIJim+KIK4QMFoBPToLX+XkRyHlJdL0ifEt
         /wMOEiin3ay+eZhGsN/Mje8lKfSCTvzvlmwaWOOQ85kxvS4+BZ1hQsgyNM7uxvHHnV
         cJdMWAVyZrQszH7Y/xNibCt2eHHodroA6dTLIAHT2AX4Fd0M/xFKy1kIsCy6b+KwUG
         s6hN4kFDEZWpi1mrThOEzSbMh39+Xk0us1+VIsqVubslupACV+nQG8Yg81nSxLzjZT
         jDr/3g+D/ZuhH5UsoPym38EDYqtVbxgzLqEiFFePC7JJOYi0RFVtYsivtGzaQQPILm
         vQ2SwaTuz5W1w==
MIME-Version: 1.0
Date:   Thu, 23 Nov 2023 23:56:52 +0100
From:   Michael Walle <mwalle@kernel.org>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: Re: [PATCH] dt-bindings: pwm: remove Xinlei's mail
In-Reply-To: <20231123172823.4offrr7w4tsrhl4y@pengutronix.de>
References: <20231123134716.2033769-1-mwalle@kernel.org>
 <20231123172823.4offrr7w4tsrhl4y@pengutronix.de>
Message-ID: <bdfe874642d0b24c7e0ceeb1109361ff@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  maintainers:
>>    - Jitao Shi <jitao.shi@mediatek.com>
>> -  - Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Xinlei is also listed as maintainer in
> Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml.

https://lore.kernel.org/all/20231123134927.2034024-1-mwalle@kernel.org/

In hindsight, I should probably have put both patches in one series..

-michael
