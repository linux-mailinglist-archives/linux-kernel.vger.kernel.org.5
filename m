Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF481076B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378121AbjLMBK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378124AbjLMBKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:10:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA49A5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:10:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64463C433C8;
        Wed, 13 Dec 2023 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702429830;
        bh=zFgCXNZVO3YDofpL6TscI323EBNpEuAQT0bTybTcNS4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=liX+i5T+scnUajZViKh42x8MMZMiyiRRENbhNhVUg5i1/PjQvViQVIk1flvTmZLhS
         KgJqYdPcJyE7pA0W68b8D7fOqZyJoBOsvVUjwmJzYN/H8rReh2I7oSpE4IJyPOQpM7
         86ZvMmHk2KZiVISDK6fJ3X7S8PCs0mEfQW+KkIRAcRuNhWpwhcOmYKH3siwZXghWBf
         MGcWQBi+zvuEO9oDEaEghr6F3LxVKq6dxEjrXJ3NPOcJ4whtj68cDOaKOWEfuOIVbe
         ZJ9XZ+1zu3OKIK1oH9vgTWN3WjwpMow08dUkQW4J/brRzCpCPf49h43btp5Vl9bQbn
         c2Z2oT/92zRYw==
Message-ID: <a2a71f27-f58c-4481-9b50-a04b61894b06@kernel.org>
Date:   Tue, 12 Dec 2023 19:10:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] ARM: dts: socfpga: drop unsupported cdns,page-size
 and cdns,block-size
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/23 11:30, Krzysztof Kozlowski wrote:
> cdns,page-size and cdns,block-size are neither documented nor used by
> Linux, so remove them to fix dtbs_check warnings like:
> 
>    socfpga_arria5_socdk.dtb: flash@0: Unevaluated properties are not allowed ('cdns,block-size', 'cdns,page-size' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>

Whole series applied, thanks!

Dinh

