Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB576E11C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjHCHSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjHCHSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:18:36 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 486E8272A;
        Thu,  3 Aug 2023 00:18:35 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 082FC60902F40;
        Thu,  3 Aug 2023 15:18:30 +0800 (CST)
Message-ID: <399a5407-d48a-089d-56ce-3ffe8eee9b2e@nfschina.com>
Date:   Thu, 3 Aug 2023 15:18:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next 0/9] wifi: rsi: Remove some unnecessary
 conversions
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kvalo@kernel.org, yuancan@huawei.com, simon.horman@corigine.com,
        marex@denx.de, peter@n8pjl.ca, johannes.berg@intel.com,
        alexander@wetzel-home.de, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <alpine.DEB.2.22.394.2308030908020.3083@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/3 15:08, Julia Lawall wrote:
>
> On Thu, 3 Aug 2023, Wu Yunchuan wrote:
>
>> remove unnecessary (void*) conversions and other unnecessary
>> conversons in the directory drivers/net/wireless/rsi.
>>
>> Wu Yunchuan (9):
>>    wifi: rsi: Remove unnecessary (void*) conversions
>>    wifi: rsi: Remove unnecessary (void*) conversions
>>    wifi: rsi: Remove unnecessary conversions
>>    wifi: rsi: Remove unnecessary conversions
>>    wifi: rsi: Remove unnecessary (void*) conversions
>>    wifi: rsi: Remove unnecessary (void*) conversions
>>    wifi: rsi: Remove unnecessary (void*) conversions
>>    wifi: rsi: Remove unnecessary (void*) conversions
>>    wifi: rsi: Remove unnecessary (void*) conversions
> Shouldn't these have unique subject lines?
Oh, really sorry for this.
I will fix this and resend v2 soon.
Thanks for your reminder!

Wu Yunchuan

>
> julia
>
>>   drivers/net/wireless/rsi/rsi_91x_coex.c     | 11 +++---
>>   drivers/net/wireless/rsi/rsi_91x_debugfs.c  |  3 +-
>>   drivers/net/wireless/rsi/rsi_91x_hal.c      |  2 +-
>>   drivers/net/wireless/rsi/rsi_91x_mac80211.c |  4 +--
>>   drivers/net/wireless/rsi/rsi_91x_main.c     |  4 +--
>>   drivers/net/wireless/rsi/rsi_91x_sdio.c     | 39 ++++++++-------------
>>   drivers/net/wireless/rsi/rsi_91x_sdio_ops.c | 15 +++-----
>>   drivers/net/wireless/rsi/rsi_91x_usb.c      | 20 +++++------
>>   drivers/net/wireless/rsi/rsi_91x_usb_ops.c  |  2 +-
>>   9 files changed, 40 insertions(+), 60 deletions(-)
>>
>> --
>> 2.30.2
>>
>>
