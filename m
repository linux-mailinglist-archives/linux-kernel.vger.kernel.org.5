Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A1F8107CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378228AbjLMBou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378199AbjLMBot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:44:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D18FB2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:44:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CBDC433C9;
        Wed, 13 Dec 2023 01:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702431894;
        bh=iSyAPZ2ui6DQUOV4s/EIyGAwUYSfCAlu+D5HjvA3FUw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LpTVvXNrU0ptsKZaGzkNUBTiIINZb0AXojLFmg9BpftOPa2/RlztEM6qz/wQHkQoE
         b4Xat99AMg9bsbJNijdlT2WX2cdTEzPNSEYt6/q1OE6vAF21JekX3b/ToBJo0gHeUi
         DOpQr45MfvkUQ7zbJTwGtZuyEkRJWRa0hfnXJkEcX91IDZME9hgmltP3U/8r2IkuPU
         dkATIH54n8dCa6upBTPjNc+QPM3bf0dO3lTNWL9aASQgL47T6/Bwbdhjs7EAXlR1+5
         M8L1EBogKS4PmMpi+Vm39ugEBRVM87UsBo+1i2BuJrag7wmWeMXAggLd5w3LH2qiif
         LoPYhhN0dbiig==
Message-ID: <360a50da-c71b-4a42-9da9-97c1ac9495fb@kernel.org>
Date:   Tue, 12 Dec 2023 19:44:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: intel: minor whitespace cleanup around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231124094620.58017-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20231124094620.58017-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/23 03:46, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied!

Thanks,
Dinh

