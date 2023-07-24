Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9A75ED3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGXITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGXITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:19:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0312F;
        Mon, 24 Jul 2023 01:19:12 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E08AF660702C;
        Mon, 24 Jul 2023 09:19:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690186751;
        bh=GCFnrMzv+rNigLSD0v1cN1fv4vmk6WyzFgWQ1ZaSsio=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GbfkbmG/lD+WW5KPpaXX5Vif3xElrqaxm7WNWoQCBGjT52O+f3oY3fZCEZes8Rohk
         CqxPTT5oGwtCB63i4Liv7WfMcFa8yshINQ2tygToyNov2laaE8qYw8mLM94QqFgvEM
         j9iN3Di1q4O2yJdO4729zStWGyG4mb7YH6KlPzTkJlF/K4M2OsDnjxqLzs8o7/h/jm
         P7+yniWWn3zHtt40KjN2tZFH9Cmy1fmfpMvl+5HBV2NIbj8L2X2rJkQYjwV77b6uYH
         UYva0bU7K3KTJ2yxg6vnpkV5r9jiuIAqIfI5xQbLnxr3BbqOLaOde0tZ9VyeDvE7T9
         ff8RJQiNSQejw==
Message-ID: <815a67c6-0006-7a63-a940-bb9e3efc7217@collabora.com>
Date:   Mon, 24 Jul 2023 10:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/5] arm64: dts: mediatek: Add hayato-rev5-sku2
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230721201705.387426-1-nfraprado@collabora.com>
 <20230721201705.387426-5-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230721201705.387426-5-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/07/23 22:16, Nícolas F. R. A. Prado ha scritto:
> Add a devicetree for rev5-sku2 of Hayato. It uses the rt5682s audio
> codec instead of the rt5682 used in the previous revision.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


