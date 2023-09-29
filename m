Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78C47B3603
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjI2Oud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjI2Oud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF238F9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695998983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4iEV8oFvPizxNdOETo7I2t4iuvcRcdG0B3tIl1ZjR10=;
        b=M3up0P5baq6sD8jY3J7yrtIPGtgbpf269u3nAppp1ypKdCcIo525Zjp7/hjNu0iEDvRYfC
        9Hz4wkVb4m6Bb6dpK7OzSVwT4urmu72FesH9xtp9fwlG8IZNRiNckJjMc+wTT67e9k4/EL
        VOPkriOAvEI0SLzfO6kOtFhindfnzmU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-zONeOzhzP42S5FHpqpX7OA-1; Fri, 29 Sep 2023 10:49:38 -0400
X-MC-Unique: zONeOzhzP42S5FHpqpX7OA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 023F885A5A8;
        Fri, 29 Sep 2023 14:49:38 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.226])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3D429A;
        Fri, 29 Sep 2023 14:49:37 +0000 (UTC)
Date:   Fri, 29 Sep 2023 10:49:36 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, vschneid@redhat.com
Subject: Re: [PATCH] sched/topology: Fix a spelling typo in message.
Message-ID: <20230929144936.GA171062@lorien.usersys.redhat.com>
References: <20230929133345.259360-1-standby24x7@gmail.com>
 <20230929134837.GG6282@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929134837.GG6282@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 03:48:37PM +0200 Peter Zijlstra wrote:
> On Fri, Sep 29, 2023 at 10:33:45PM +0900, Masanari Iida wrote:
> > This patch fixes a spelling typo in toloplogy.c
> 
> Please, google before sending patches, this is not a typo. Your spell
> checker is broken for not including humour.
             borken


-- 

