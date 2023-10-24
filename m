Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1D7D4C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjJXJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjJXJ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:27:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69DB1703
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:26:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C5976603102;
        Tue, 24 Oct 2023 10:26:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698139583;
        bh=x0hoEPrZVpDP8h39Ok3fCECmUX60IQWzTwTBbMbxSLw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Ce9179+qx9pPm44JUfD0tJRXYpicaelpwO+Odd61yCpYnmAZ5s9P02yZn5ttY+A6r
         pCYS1artduAaa/0dE9tSDqjMf7pSaHXpmWNeMg3D2ZfQZXHujsHO5ISRxs7rGR/i+E
         OfUHa22kpx1q/A1QwIIapWiQEFUBp/YWGMkAfUhaKxfdXuzdzAOgETnEhEr5fGqufk
         QW2gIWyZMfQwE5Gjez6vguZJKU7iGitWb7of0eP32mONUEaHcIy1mu6ekaJ7s80mM9
         fp4Cnk1nV6Tjx2Pv2gQtubXGK+thr1yqtk/s91r1LUoWjktfEmRBIMDgZanXhpEWIH
         R1OyQbH721FXA==
Message-ID: <1b92e452-c325-4f6f-8ac3-22086c4a7b2e@collabora.com>
Date:   Tue, 24 Oct 2023 11:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ASoC: mediatek: mt7986: drop the remove callback
 of mt7986_wm8960
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231024035019.11732-1-maso.huang@mediatek.com>
 <20231024035019.11732-2-maso.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231024035019.11732-2-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/10/23 05:50, Maso Huang ha scritto:
> Drop the remove callback of mt7986_wm8960.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


