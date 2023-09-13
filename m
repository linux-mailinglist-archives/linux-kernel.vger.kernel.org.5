Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4779E33D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbjIMJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbjIMJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:11:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ABE1BCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:11:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF53E660732D;
        Wed, 13 Sep 2023 10:11:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694596293;
        bh=FtOpkAdzQ58onbp7Njaf6MPGcxX3jvqgfRoBdwKnAdw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PO6qr5kD4IQ0uzj/oKlPpQeZTfUTgetY0C5HXTV6uFBzcAd9lWCSFc/KKunqJ0hyY
         j0IXVNavi2s0efwex9sO/SXFcBgNjFvHkTKDGE0qCiI05Orp/CV0CFxmaCozLBsB/2
         Wqxs1q6SRT5ppm7xYvmeQKi+3KQolYp1+Ak8H68mZorlAwFLcKUE1/ZPX4j++hU5G1
         xOiTFaGGlrHZYcHzlAOPr4WQUPaPPkJBHCH4MPXexwM1YAU/egekpBzA6XOuscmzgA
         7AAQhQmQsFdfz0EsnVJR23zZYeOJjSMydeLi17PatwI6scKi3NLWBDEJ+e3dNjxMQQ
         MgklUKLCkyCYQ==
Message-ID: <2d78548a-6b4b-cd6f-6466-5d8ff4de5a1f@collabora.com>
Date:   Wed, 13 Sep 2023 11:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/5] spmi: Use devm_spmi_controller_alloc()
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230824104101.4083400-1-fshao@chromium.org>
 <20230824104101.4083400-3-fshao@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230824104101.4083400-3-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/08/23 12:40, Fei Shao ha scritto:
> Convert to the device-managed version of spmi_controller_alloc() and
> simplify the excess error handling code.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


