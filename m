Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03E75820D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGRQYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGRQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:24:44 -0400
Received: from out-14.mta1.migadu.com (out-14.mta1.migadu.com [IPv6:2001:41d0:203:375::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7DB5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:24:43 -0700 (PDT)
Message-ID: <77cbc2f6-c574-19f5-7277-cc85afefe855@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689697481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfcgypQOAxzvXKZanWnc9PpMkW6aFsIfrCBY7LttHdk=;
        b=SROZTuSO2XZiJnsvUFQ3QJqxa2GSqhCn6XwN4/0xhKR/OJxXTJg+D8KxG8xTy28x3lwFoS
        XMe5b+wC3t//Vj3+V5Dr00N207aEb3CLnSUMy/Afg4E1EYQeuW2ugepxm+TuhLW/aJ8SIQ
        8KxuNYFQjlvuKnB8WiVGzkGypUP360M=
Date:   Wed, 19 Jul 2023 00:24:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/8] drm/etnaviv: Drop the second argument of the
 etnaviv_gem_new_impl()
Content-Language: en-US
To:     suijingfeng <suijingfeng@loongson.cn>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
 <20230623100822.274706-4-sui.jingfeng@linux.dev>
 <862358e67a6f118b11ba16fb94828e9d1635cb66.camel@pengutronix.de>
 <e3a05204-61fe-2318-5f06-fd12addfe2e9@loongson.cn>
 <ee96ed1a1ff12656f6e6542ae928fb526a9758fe.camel@pengutronix.de>
 <06b291d4-9cab-5179-2a90-a73449ddb2dd@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <06b291d4-9cab-5179-2a90-a73449ddb2dd@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_TONAME_EQ_TOLOCAL_VSHORT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/19 00:16, suijingfeng wrote:
> Because communicate will you


'will' -> 'with'

