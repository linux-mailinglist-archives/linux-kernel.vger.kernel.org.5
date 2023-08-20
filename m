Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70908781ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjHTQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjHTQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 12:35:44 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246161718
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 09:31:50 -0700 (PDT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-565aba2e397so3699973a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 09:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692549109; x=1693153909;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zs/80MywMGN5nz//xF6VCFq/BEhESsIQ+1ZAkPDALbk=;
        b=TBoHkwiafT5/KiKjG6VQ8MhcdHakYUHDoIIngO5ZsY9K8vIABmPL3wlsEfJAnjl6de
         wlv8kLfKFsrNd2o79PR2kAmYjJGk1Pi0vflhC4xbWU+ffmXVWWECKoWCVfRrF94Z7MBI
         O5fAX3nvYGxFBVycYTDn6XsctTvnb8KJA1tFvFOjMBDKpdQ4GRk/HkvwJb5TtD/of+Kv
         J9IW939b+ZR1vwmDkeTQucnxq3h2FlCvdJYjS/3Xf9ibKb2wBRLTvBQekkejPYr/vQdj
         ayPwodTB2EbvqnVpX/ygmv1QaAgDp/GCOG8HBiIrB6ncw1lA/jogBJOCyogGsYGWLoxD
         Q2ag==
X-Gm-Message-State: AOJu0YwnFAz929VKX+DScwrQAqIl+ljMYdlNW6q4+PFgI9QsXnVjtySm
        V9UqtFkb3OmvMYzwYubSh5ymjptzfrK8tWFlw5honn+NehD9
X-Google-Smtp-Source: AGHT+IErhqdhvHhVckGfIW/XLXNm4JqtQuA565sNNBhC+CqBhOhSA7xFnKkvkT/G/qpRMs4iUai8h3DEsavT5Ko3eLEIRZY3rxjo
MIME-Version: 1.0
X-Received: by 2002:a17:903:189:b0:1bb:cf58:532f with SMTP id
 z9-20020a170903018900b001bbcf58532fmr1899889plg.0.1692549109491; Sun, 20 Aug
 2023 09:31:49 -0700 (PDT)
Date:   Sun, 20 Aug 2023 09:31:49 -0700
In-Reply-To: <20230820163131.205263-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006faceb06035d4c37@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
From:   syzbot <syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com>
To:     code@siddh.me
Cc:     code@siddh.me, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Cannot reproduce with the repro locally, check on upstream again.
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Your commands are accepted, but please keep syzkaller-bugs@googlegroups.com mailing list in CC next time. It serves as a history of what happened with each bug report. Thank you.

>
