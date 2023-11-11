Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD83F7E8B38
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjKKOa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjKKOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:30:27 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0627F3AA0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:30:25 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc5ac304e8so29830905ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699713024; x=1700317824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdxyUKehNOG9qySTWNyoT0oDjMPzMO1YebcbPuN1Pr8=;
        b=PhSDoV4dSzc3YEL5AkZYZrnEGTNACwyg46ztvKLUGXwxX5WL+7u/iBnLZz2qVloJCY
         4HiRtC6zCWBZfQlSGt0d3KXuuFcebYsWyah8gZJzsZ3ISYRgi6odoTuMKdfv/AC7k2Ll
         im5Bz1ZFPWnXQq6Ve+OwYxisQWUhr4gdAbdwvGuTNU62+di8uZfj3c8ChcxDFcw7vIZG
         QUPis16lh7ArqSp5RmRp3M4VYtwEfyCJi/nbaR0Y6SyDVUgkWGVg5r2SfgcIyiibFe9x
         qR7j9KTjW+RY1kBjsq3hPRhAGTt1tvUQI0r17yDUJJsxzEocFA+QVMlCVM83nvC46iLC
         MWnA==
X-Gm-Message-State: AOJu0YyUj96W2It6BY1KARw6scXDi3zqjx73j4zR4W4rkyNxAuo/t6h/
        +Wu+xlOiQOP84vahz7EI4AKmoJpM6gpinN/rqXrjUfNdec9v4oU=
X-Google-Smtp-Source: AGHT+IGQ0omprvwfRQiNiKaClAO27/2n3sxJdJnUssO73u+EKes6mGTUs3alz9euolTA4ujJFGXBr51v/+72vmYrnufMAXsN2oLZ
MIME-Version: 1.0
X-Received: by 2002:a17:902:ef95:b0:1cc:5d23:2792 with SMTP id
 iz21-20020a170902ef9500b001cc5d232792mr565925plb.7.1699713024184; Sat, 11 Nov
 2023 06:30:24 -0800 (PST)
Date:   Sat, 11 Nov 2023 06:30:24 -0800
In-Reply-To: <000000000000acb4b105da650b31@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006d7ff0609e14723@google.com>
Subject: Re: [syzbot] syzkaller test
From:   syzbot <syzbot+c5732f0517748c2c8051@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: syzkaller test
Author: yuran.pereira@hotmail.com

#syz test: https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
