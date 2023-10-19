Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154557CF555
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjJSK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJSK3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:29:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0852FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:29:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3197FC433C8;
        Thu, 19 Oct 2023 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697711390;
        bh=yqtfTXin7HKdqdcd8Cdk8vhzxiHzQgV3bZzfYAgIZDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXzj+37hOTHesLIU0vdPIKRzAbhnzkSeiB99HJjfqqjx//t7aQxRMjK/KovjwYceR
         A31TmG7RV77PXJ9wPx1m3lpMKoeYUeJVgHJiJ55TrcUj7SMjkYmsvjBYp/jB8f2nel
         HggyhUgNmzufjA9ORfsGrG6rW7MVe2JtVoo3+2O027Ff2v7+eva3oOzV+fU/m3WKgy
         vb3ADHqVViGDFDc5lB4G8bQIRlpCfGmup5g1AIQHiYAh7cHC4Krj2KFl7nVBZpO9Ez
         FGbP67j5ou2K846SN5+DWY2DgIbXrE9VRJUpTsRHmnjB41boFHbvOmrGQKbkpZDPCi
         PVddKvtzgs89A==
Date:   Thu, 19 Oct 2023 11:29:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: rk8xx: Deprecate
 rockchip,system-power-controller
Message-ID: <20231019102945.GA2424087@google.com>
References: <20231010174138.1888396-1-megi@xff.cz>
 <20231010174138.1888396-2-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010174138.1888396-2-megi@xff.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023, Ondřej Jirman wrote:

> From: Ondrej Jirman <megi@xff.cz>
> 
> Deprecate support for this property in favor of standard
> system-power-controller one.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml | 3 +++
>  Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml | 3 +++
>  Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 3 +++
>  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 3 +++
>  Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml | 3 +++
>  5 files changed, 15 insertions(+)

I don't see anything wrong with it.

It would be nice to have a DT Ack though.

-- 
Lee Jones [李琼斯]
