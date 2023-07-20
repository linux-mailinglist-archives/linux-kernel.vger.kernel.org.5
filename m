Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA6575B26D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjGTPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjGTPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375E3132;
        Thu, 20 Jul 2023 08:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF4EE61B4E;
        Thu, 20 Jul 2023 15:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70872C433C8;
        Thu, 20 Jul 2023 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866640;
        bh=Ctw5hFIPSjBpTaDRLOhcVdvyPSjKTTNb0sCDJ8BLAdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nax8IhRWacQd40Kfnj891JTacjufb/tRvDnfaNMMgNIJfU2lc84lz6TmXZcHkZGe0
         9dN84djSDAhEE8uVJvosuiYeqtDNQDyaOLTZiKLjWal4WkebmD2HhETQdH+1X48LOI
         gh+bazxZocy+LEOeLBskFc3uX5qQ/nttSRwvCMsXZL/GWhMtbnpE1YAxL3LYRCofRq
         dZZVzNpF+3b4UurQr4OBOCKp7O8/eK8NmaKUxLEeqeJXPqkUZjCFUITQk4IUsEiDzn
         dtgF+LGWCWlaXw8qSMgK9mzhCKk/KZ60nCIrcDx3pso/U3HzMIuV7E1+siSMjVBN3y
         wL3fl/uZW5KxQ==
Date:   Thu, 20 Jul 2023 20:53:56 +0530
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
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8180x-pmics: add missing
 qcom,spmi-gpio fallbacks
Message-ID: <ZLlRjLQ0bzCkwtX4@matsya>
References: <20230720083500.73554-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720083500.73554-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-23, 10:34, Krzysztof Kozlowski wrote:
> The GPIO children of PMICs should use qcom,spmi-gpio fallback:
> 
>   sc8180x-primus.dtb: pmic@0: gpio@c000:compatible: ['qcom,pmc8180-gpio'] is too short

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
