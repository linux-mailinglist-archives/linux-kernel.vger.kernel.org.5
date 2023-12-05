Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16216804700
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbjLEDdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjLEDdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:33:41 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 50F4E11F;
        Mon,  4 Dec 2023 19:33:46 -0800 (PST)
Received: from [172.30.20.54] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 93A09605CC808;
        Tue,  5 Dec 2023 11:33:36 +0800 (CST)
Message-ID: <56b21cd8-7634-895e-6610-2a087ce8fc13@nfschina.com>
Date:   Tue, 5 Dec 2023 11:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/3] scsi: aic7xxx: fix some problem of return value
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <d37560ef-d67f-4493-a7bf-1d192ff7351d@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/1 15:53, Dan Carpenter wrote:
> On Fri, Dec 01, 2023 at 10:59:53AM +0800, Su Hui wrote:
>> v2:
>>   - fix some problems and split v1 patch into this patch set.(Thanks to
>>     Dan)
>>
>> v1:
>>   - https://lore.kernel.org/all/20231130024122.1193324-1-suhui@nfschina.com/
>>
> Would have been better with Fixes tags probably.  Otherwise, it looks
> good to me.

Hi, Dan

Sorry for the late reply.

I'm not sure if it's worth to add Fixes tags.
These codes are very old which come from "Linux-2.6.12-rc2".
It's seems like a cleanup or improvement.

Umm, should I send v3 patches to add Fixes tags?

Su Hui


