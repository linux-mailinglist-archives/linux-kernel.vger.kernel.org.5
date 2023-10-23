Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F17D27FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjJWB1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjJWB0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:26:53 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 33375D41;
        Sun, 22 Oct 2023 18:26:47 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 8D33D6047A8C6;
        Mon, 23 Oct 2023 09:26:35 +0800 (CST)
Message-ID: <394deb86-89c8-9e77-eb92-8fca21997083@nfschina.com>
Date:   Mon, 23 Oct 2023 09:26:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] i40e: add an error code check in i40e_vsi_setup
Content-Language: en-US
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <58d18354-dbd6-47d3-93a8-ba0446dcc8f6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/21 05:09, Jacob Keller wrote:

>
> On 10/19/2023 11:56 PM, Dan Carpenter wrote:
>> On Fri, Oct 20, 2023 at 10:43:09AM +0800, Su Hui wrote:
>>> check the value of 'ret' after calling 'i40e_vsi_config_rss'.
>>>
>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>>> ---
>>> v2:
>>> - call i40e_vsi_clear_rings() to free rings(thank dan carpenter for
>>>    pointing out this).
>> Looks okay now.
>>
>> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>>
>> regards,
>> dan carpenter
>>
>>
> For some reason this patch doesn't appear to have hit the
> intel-wired-lan list and is thus not being recorded in patchwork for IWL.
>
> Su Hui, would you mind please re-sending this so that it gets picked up
> by patchwork? Otherwise I'm afraid that it might get lost inbetween when
> Tony returns from vacation.

Sorry for the late reply, I have already resent it[1].

Su Hui

[1] https://lore.kernel.org/all/20231023012024.18757-1-suhui@nfschina.com/


