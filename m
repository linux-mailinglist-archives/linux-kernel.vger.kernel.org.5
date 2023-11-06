Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669B07E25C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjKFNfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjKFNfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:35:03 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53616D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:35:01 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e9adea7952so5280245fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699277700; x=1699882500;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=It27bJtObKcYcJZpEzZugZc4YKyRkKB23O6gcETInwQ=;
        b=qS0rzjklMg928bM2y3tPQuvIET1Iq+9w6vbMeL1qeRommIJxs7mpV3W4FO6NGkesFN
         KvKgC7bnjIqKv22BAXvB0nb9yAnvHjUj/pZmFX1qOJCi8/t2M8Ggi1yS6bUnGvHNzTsS
         l1wdnGPPPbUtY8/E9h3Ee45tB5lbpqbBEGIYacDilyLZ2WX4dxBW7NSSGmAFQXkdCBhO
         KMk2iY8I0BZf3CcxSdema9BXJsI77wL1vjpO3gZWHCcDwnsDhUMSpXUL4LKD1+UGIVw6
         9xLABrKv+ETmWDPEK9omA0D4WIoSzqKBXCCo3bgPXcM7X++Cg1UU9FEv43CakMSd0s0o
         ndIw==
X-Gm-Message-State: AOJu0YyhlqsrQWUEOBY79yCmrFK97thUuLL0/GxzFbmXaiXFu9avCsZQ
        SAsdG7M4YCrazYNCp3RMT3Ar8TuMH+L58BTJho3+6G9YFazJo98=
X-Google-Smtp-Source: AGHT+IGCgMk7Slry7hUJIgnva4Oo/yX7gr0DBi1o/E73wOzul9hHiXYl/L5jiapwGpnADIKD6SB75bYIs6gxVWja+RZ+gHB5oG3q
MIME-Version: 1.0
X-Received: by 2002:a05:6870:164a:b0:1f0:36b6:ef34 with SMTP id
 c10-20020a056870164a00b001f036b6ef34mr6601003oae.9.1699277700645; Mon, 06 Nov
 2023 05:35:00 -0800 (PST)
Date:   Mon, 06 Nov 2023 05:35:00 -0800
In-Reply-To: <000000000000208dc20608a2cbb4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8c92906097bebbd@google.com>
Subject: Re: [syzbot] Test
From:   syzbot <syzbot+84f695756ed0c4bb3aba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test
Author: yuran.pereira@hotmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
