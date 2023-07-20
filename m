Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7130A75B273
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGTPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjGTPYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:24:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E932711;
        Thu, 20 Jul 2023 08:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 782FF61B4C;
        Thu, 20 Jul 2023 15:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26677C433C8;
        Thu, 20 Jul 2023 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866651;
        bh=sR2jF6kdNmJaMDgPDcpCZyfAUacoMe++hWRUDrPeHks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UaSeV2a6wM2amMR9lIPbub7z3FHATXNt/joiNQ8ysKcR+ZiMknyziJWTudDj2OKCJ
         eCIkOfTmoLC04SlmQ42MOuR+w7n7NlqC8QApOkBPuLrVqQQv4hbMBrJ2NWnhM9Q8xT
         I8uReXuNuYmZshh1825lRR23+xyWxJ+rdjhUuJogNkp8HlFNzL+AzqP0LYMWSyQwtC
         GWhInvA/bmuZt5P6IXO2+YWwsFTpwoebj0p1ORdmq9hByxLBFS4viq4oYG065lGEBy
         +N3FYYiqwwJG4DYHa2DYeMTP83kirByF4QJIljQt8sc7MnVyVYMMYZRwFVqQmESPE+
         +SrgUNrW7GdPw==
Date:   Thu, 20 Jul 2023 20:54:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc8180x-pmics: add missing
 gpio-ranges
Message-ID: <ZLlRmKnp3IYaQySJ@matsya>
References: <20230720083500.73554-1-krzysztof.kozlowski@linaro.org>
 <20230720083500.73554-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720083500.73554-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-23, 10:34, Krzysztof Kozlowski wrote:
> The GPIO children of PMICs should use gpio-ranges:
> 
>   sc8180x-primus.dtb: pmic@0: gpio@c000: 'gpio-ranges' is a required property

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
