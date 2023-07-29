Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FC3768056
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjG2PRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 11:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjG2PRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 11:17:41 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672201BE5;
        Sat, 29 Jul 2023 08:17:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EEC5C381;
        Sat, 29 Jul 2023 15:17:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EEC5C381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690643859; bh=rsl3m7diQyM6bFl0qQ44w6X1aNzJRE7I8OxZZqsIUtQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EFHQaNEkq/K2YmbULf2/ZM0Y3RRwXrIHwJzIFq6qLppBxxwgMbJi0QU25vpnWpC7b
         g3u47jy0MF6R+47lI31TQFxxv+B2mv3kv0VClYXE7/zLZ4ZK2GbpY4aySEPc9WpCU8
         6DhaNXbiZ4lazgeDOSFGJSaQf2WPjmj3IeWqrJPqp9xgep0OKLskTDq4nv+vRohQ+w
         pbwdxRpqJnpYfhQm1OECM+2M3oss89CQhwHhGTOKFA6wbK3st1m0w1UYi3f8VfZjRN
         weHmnu6yqY0Qs4NeY0xecENVDJBopNHq3OEyXVRG+/IySByusLVjkZnAMphmB+6ZTC
         pczfhr+lOmgoQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] docs/zh_TW: update zh_TW's documentation from an
 ascensive aspect
In-Reply-To: <6ae7f65b-593f-75bc-2f34-c08de719b2fc@gmail.com>
References: <20230724041715.20050-1-src.res.211@gmail.com>
 <6ae7f65b-593f-75bc-2f34-c08de719b2fc@gmail.com>
Date:   Sat, 29 Jul 2023 09:17:38 -0600
Message-ID: <87h6pm4ui5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res.211@gmail.com> writes:

> Did you receive my patches? Please get down to them soon because I have
> another series of patches pending on until the current patches are
> resolved.

Yes, I receive your patches.

I'll ask you again: please be a little more patient.  I will get to
them.

jon
