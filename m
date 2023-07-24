Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CB175ED41
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGXIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjGXITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:19:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3867693;
        Mon, 24 Jul 2023 01:19:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8BFA4660703C;
        Mon, 24 Jul 2023 09:19:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690186753;
        bh=urkKoxu8DIqx9yaZETGWB5AtfWNXPKcI9c8Y868BmLs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n/ZOVuMLH2lulIivPNWAKcjQmEyX4SXp/kPvPpp1cafw/UCiLs8pJPtU9Cg6Qe73r
         BsqlU4EHl+MuUou2YVE0NLliNjw5ETWwgzhazT2vEa50k2lK2dynt9uZFBMbgkq2cr
         cGIglMFfZBmaQw3gfzh/txrAloYyVW5Twjb/6iEKgnbLrT8895xqC8YsR2iX2Hq+mj
         dyicOcRlgfdd4wSRNMiEh0ZSxSllpZGL4D0V4S8HjHzYMx7qlIVOWY6Qw/I+GaeHlL
         Sd1WrsxKvAsPCO81rtJx9DZlQP+YRB9j6DrbHQjRAt0XMXgO7pH4/kyf5ZJrJzNHfW
         yQsM/OTkszrmQ==
Message-ID: <c40a6205-7f4a-fe61-9b66-4bbc57304831@collabora.com>
Date:   Mon, 24 Jul 2023 10:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/5] arm64: dts: mediatek: Remove asurada-audio dtsi
 files
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
 <20230721201705.387426-4-nfraprado@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230721201705.387426-4-nfraprado@collabora.com>
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
> There aren't enough users of the common asurada-audio dtsi files to
> justify having them. It is simpler to just have the audio nodes directly
> on the board files.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


