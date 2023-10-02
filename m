Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA8E7B4C84
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjJBH1E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 03:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjJBH1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:27:03 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E428E;
        Mon,  2 Oct 2023 00:26:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id D11FC1865484;
        Mon,  2 Oct 2023 10:26:53 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EGJ8tBZbybyi; Mon,  2 Oct 2023 10:26:53 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 6B7D51865147;
        Mon,  2 Oct 2023 10:26:53 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id emH8Na_9A7FH; Mon,  2 Oct 2023 10:26:53 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.102])
        by mail.astralinux.ru (Postfix) with ESMTPS id A843518639B7;
        Mon,  2 Oct 2023 10:26:52 +0300 (MSK)
Received: from [10.177.232.254] (unknown [10.177.232.254])
        by new-mail.astralinux.ru (Postfix) with ESMTPA id 4RzXZg5tKQzYcn0;
        Mon,  2 Oct 2023 10:26:51 +0300 (MSK)
Message-ID: <9e6d5cba-d40a-ff44-3400-d86d8257e98a@astralinux.ru>
Date:   Mon, 2 Oct 2023 10:26:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2] drm: rcar-du: turn rcar_du_group_get() into void and
 remove its return value check
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <169383224922.277971.15400887308406098634@ping.linuxembedded.co.uk>
 <20230927104438.30628-1-adiupina@astralinux.ru>
 <20230930145032.GD31829@pendragon.ideasonboard.com>
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGA0LAg0JTRjtC/0LjQvdCw?= 
        <adiupina@astralinux.ru>
In-Reply-To: <20230930145032.GD31829@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

I'm sorry, my mistake. Thank you for your comment, I will be more 
careful in the future

30.09.2023 17:50, Laurent Pinchart пишет:
> Using tools to find issues is fine in principle, but not even
> compile-testing the resulting patch before submitting it is not.



Alexandra

