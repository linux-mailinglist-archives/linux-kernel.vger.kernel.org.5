Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444907BA488
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbjJEQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbjJEQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:38 -0400
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECB1A5D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:33:37 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id ABF0B2C82;
        Thu,  5 Oct 2023 09:25:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz ABF0B2C82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1696490704; bh=uqageofBxJ1YtP/KDEuhMZfcT6e54HWw74KlynWoEMk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B5+7rsupQ8yJzg8v+25jomnkh/wd4XGVIuJqGInSAuotujuHTDpz5eNJmv4XLLbSf
         1MPrYeZlpEWUEsT5Z39PpWuBOwFSAZtT5lIbb0q4Q8kGE0xzr3OzLrZ/ehKED5MpIk
         QO8RH3lr1pTEzU4N4EBqThsMS18aSsyodO4N0hws=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu,  5 Oct 2023 09:25:00 +0200 (CEST)
Message-ID: <caa80bb4-7e24-3e7b-91ea-e3ccbdd2af6d@perex.cz>
Date:   Thu, 5 Oct 2023 09:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] ALSA: aloop: Add control element for getting the
 access mode
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230927113555.14877-1-ivan.orlov0322@gmail.com>
 <20230927113555.14877-2-ivan.orlov0322@gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230927113555.14877-2-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 09. 23 13:35, Ivan Orlov wrote:
> Add new control element 'PCM Slave Access Mode' which shows the access
> mode (interleaved/non-interleaved) for the PCM playing device. Add
> corresponding control change notification calls.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

