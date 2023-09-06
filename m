Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4127936C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjIFICl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjIFICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:02:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62424CEE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:02:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721C9C433C9;
        Wed,  6 Sep 2023 08:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693987355;
        bh=zmyW96oufhW8RAznv87Q91mLlrLwARrAfGvvOlVq0TI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IL5+fF4+1Fzxw4zM82XIzY78DaaIqIEwbkAXk8L+zouzHd3P7qLSEW7l3CEqFNIQm
         xEgvdbXTcVg6EUyXbpJgX1DHGfoLJu1HUC1LqHOwvBOS7FOwFtVkST7Fg05dzmPJMJ
         7WHHD+i+UkHbhtHQ+IzO43jmCj5jvjeG6H9UK2Dr+HmLSLJ5krhKKf0b1y//cc1QWe
         WybiZ+iB/14BasD5RiAbK/AHyuj77MczJ14Zz7d7jQ4Dj4jsl1YFzinJUtc4cxMDCx
         TgJVHecDppIQUJRaux6AKDq+dQfTyI7Q+YXHENS8HiDWcvTEHegsRc/Myr8rcIC8bT
         gs4GhpoyBL1hA==
Message-ID: <2ee5974b-a8a9-0c6d-3f59-7cfedaa09c55@kernel.org>
Date:   Wed, 6 Sep 2023 10:02:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 8/9] tty: serial: add tty over I3C master side driver
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, miquel.raynal@bootlin.com
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230905213842.3035779-1-Frank.Li@nxp.com>
 <20230905213842.3035779-9-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230905213842.3035779-9-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 23:38, Frank Li wrote:
> This is master side tty driver for tty over i3c.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Why do you skip Cc-ing maintainers?

Best regards,
Krzysztof

