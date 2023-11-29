Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAAA7FDCF3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjK2QZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2QZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:25:12 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D188F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:25:18 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-285adde28a0so7211049a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275117; x=1701879917;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
        b=Q3DOW90VvWkQMdLg1PkU6LizgZyLrtcj+Det3PlsYmj404ELm71/LxT0z6mgevDKO9
         jZCe31Kr0yasaCSMzfZH50NNjxtQSOxKIRLTEGd0U8EYTGXKOe94UeCC7scawYXjTsvb
         a4qV7ChuAHkLRCT2AR4VBo6Jva3M6Huymap4pMx9Gcmt+B8hh66O0C0joEb6Da8gFYHo
         4fwvl3oBwVvRQEoaqzy3PObKVpjm6aeHP0a+90N1FVsTNBZt4W6ey2O+8jw9Ds8pRfd8
         RfI64eJJmxR6YtHq8kkDy8RH1tENT5u1mRhhXc36RgofNTTjkxitDxi+3qf/dFnbe0vz
         2VVw==
X-Gm-Message-State: AOJu0Yxb5TT6a6l8FccEk5iSnCtk4L4aZFT2X5K9+y5bJWl+0mvar1Cz
        0qHp1SxtCMjjtvgN5CZ8Ar6B/nI2qKFfYLLovonPY7Cqs3Hl
X-Google-Smtp-Source: AGHT+IGtasBru+aimRd75t36Hqr3SvF5lw1FcWGAIDmwZ5gKIWem8XZj8HEcO+MUiBnm7YGyBHD5Hh8bMnVZvMX6/eurV2JP+O10
MIME-Version: 1.0
X-Received: by 2002:a17:90a:69c4:b0:281:1c2e:9e6c with SMTP id
 s62-20020a17090a69c400b002811c2e9e6cmr3784491pjj.5.1701275117661; Wed, 29 Nov
 2023 08:25:17 -0800 (PST)
Date:   Wed, 29 Nov 2023 08:25:17 -0800
In-Reply-To: <CAK6rUAO5ETaxQ16tV53Mnmi9vwR9Sw+aQs11mPS_eTXO-AeA=g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000db585060b4cfbc5@google.com>
Subject: Re: patch test
From:   syzbot <syzbot+2cb7b1bd08dc77ae7f89@syzkaller.appspotmail.com>
To:     osmtendev@gmail.com
Cc:     osmtendev@gmail.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test

This crash does not have a reproducer. I cannot test it.

