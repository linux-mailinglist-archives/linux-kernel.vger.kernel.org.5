Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB2754695
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjGODgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGODgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB38131
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DCFD61D9C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 03:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F285C433C8;
        Sat, 15 Jul 2023 03:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689392179;
        bh=c3tslDX7l0mK6db/sbQQSGrMSv0gZmxNU8aa2qw8Exw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lH8cEjJgrHWp90asOlEIXOLgBx+AxBeW+J0hbuFVxUmlG78xQor+z1BUWToZ1CA7r
         cn1o8Jc7NKEbU1HT7ArlrBCCfJYvwNQupFLPc4kgws4ypai1Ypr4XzLhaJ2bZLeOdH
         Gg7AeK3fBXDF8T9k+rOop6SM+4keVwFP0w24t2f3IwyYkzMr/kjo9HOKUrA/LSO7i9
         m6OLEWszrWqQXhVnZ0UlXEG00ej1IXteKgMST95UOGVjtD5EJavIfZWvnAinP7GaeA
         KEdJvTMUTYbsXFgo6nGgGYmBp7W+4pCLtJPLWUTtAU3ZIv/sNyQ0AVTwpH2CWVbVOr
         VoE1+eFU5IyIA==
Date:   Fri, 14 Jul 2023 20:36:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     hanyu001@208suo.com
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/slip: Add space after that ','
Message-ID: <20230714203618.2e19e8ed@kernel.org>
In-Reply-To: <4b922e9203381b3411696feae9ee02da@208suo.com>
References: <tencent_C824D439C8CE96AD83779E068967114FF105@qq.com>
        <4b922e9203381b3411696feae9ee02da@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 16:02:13 +0800 hanyu001@208suo.com wrote:
> Fix Error reported by checkpatch.pl
> 
> ./drivers/net/slip/slhc.c:381: ERROR: space required after that ',' 
> (ctx:VxV)

Don't send checkpatch fixes to networking, thanks.
