Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973D37A4582
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbjIRJGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbjIRJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:06:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E98120
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:06:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D49E6607083;
        Mon, 18 Sep 2023 10:06:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695027985;
        bh=ZNtyNW62zjspEPudHJr6SXTUwT0rpU4X7UOJOlD7GTA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LOt26kMneQp6FbI5o8wymzryUX7DiD9PSiZvDjEIEhiPdvMkZiMJOI+lFx7oItgps
         ucWz2SKUjSu6uxApdpmimZCW+QYMXWzyRDie9BqkS7MQqvjomWWjTPai7XPsb9dz5H
         GiEHOyRbPyaJeTiTypPO5sInn/gl0AlTZis2epJMGlFBS8qolN9Vd6agVHEXXgB8yc
         S+xPNerFhya2VHxRRvu4+osKO+VUq/L3YVEfB0+dgHcHMQVEmUhWOSVazLM0oKYX2L
         ifiowaQajQmZWP0Bd502j8FbmyFEidGLM7zZFmoWqb5aoeTe8c1lGK2qtFZZ/60mQE
         ZZH80VTtUgS6w==
Message-ID: <d808df62-1cbf-dcb8-ad15-837dd2b715bb@collabora.com>
Date:   Mon, 18 Sep 2023 11:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 01/11] soc: mediatek: Add register definitions for GCE
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
 <20230918084207.23604-2-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230918084207.23604-2-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/09/23 10:41, Hsiao Chien Sung ha scritto:
> Add register definitions for GCE so users can use them
> as a buffer to store data.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

