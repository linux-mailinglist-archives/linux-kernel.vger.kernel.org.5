Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8130678A65D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjH1HRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjH1HQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:16:53 -0400
Received: from out-245.mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB08F1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:16:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693207007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+/16oM8n8d6kms2BRHOYDMGKrLXKAWwuWqFHlefWFk=;
        b=B2v0DXbHkT965+9lYPZm2s1Q2j/0cOA6iegXt9LvjjJBRto98YNH+KZ9f0zkzfrpqVsYKD
        Ip43OmY5wknVei9KRhgYftNimgDkKhJ0Qurq/04GZCvG9FMmHfQW21uvT3lD8NOzWbIZOX
        D4I5MO15j+j34EAKBq4pqrmdrlDytTk=
Mime-Version: 1.0
Subject: Re: [v3 2/4] memblock: pass memblock_type to memblock_setclr_flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230825111836.1715308-3-usama.arif@bytedance.com>
Date:   Mon, 28 Aug 2023 15:16:14 +0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Content-Transfer-Encoding: 7bit
Message-Id: <D8A2AB65-E08C-4418-B7D1-C344C9F54622@linux.dev>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-3-usama.arif@bytedance.com>
To:     Usama Arif <usama.arif@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> wrote:
> 
> This allows setting flags to both memblock types and is in preparation for
> setting flags (for e.g. to not initialize struct pages) on reserved
> memory region.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


