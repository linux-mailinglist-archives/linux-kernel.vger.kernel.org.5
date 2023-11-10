Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C47E825A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346092AbjKJTRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345940AbjKJTQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:16:50 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C1C7E31
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:56:15 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-58b2e2af00fso2254918a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699642575; x=1700247375;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjOej5IasCQ3eNYdagxH0Jo3psejeS5vJKKqQq+wp1g=;
        b=m2N/EMihI/svAI2x8JPV24mjcNkmOXZS5pnTQzMl7ZDbWgAm9RAqJqpd1OJiWGiH6c
         NGCJi0terIVXpwsQEzJwo/B9oTMNexFiF3Cda9aHGA63DFU9cFsNs3f2nLwvFb91KkHH
         GA77LFcdzV4qowA8uawCPFCRxbnLdBNc7oMaUae5s3xjTDMEuQXMjImZPE4hF8QUV7KJ
         dyQmQJg6CJEwY6cHo0+oC3dsdnEc1GCOpxZrPH2ck2UirUvQL98A+YHPnVLRhnjdici+
         4+Gfn8xoydp7oy5i5pwOod0KKYZNHfCPS8/Qxuxii7ru+PyaO6KBDMogGG19uYMni0Ws
         NXoA==
X-Gm-Message-State: AOJu0YzpXIZmcm//io2LdJpA6hxIXbaor+UUr6Ozi2GZifmKblSknmB2
        EtxazPx1iBCW45xew01F4ui0NmyZjkLMFgyW2outZw005GXvyxk=
X-Google-Smtp-Source: AGHT+IEI/iIlcIIdUGsaoo1vVd1GCQXMzeSLjIWMFQSMdi+GEDx5P4toeO4ZRvRiabk7APLtoLuHpbWNL7ofWytomA/pRTK9Azfr
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:613:b0:5bd:3d6e:26fd with SMTP id
 bz19-20020a056a02061300b005bd3d6e26fdmr44268pgb.0.1699642574869; Fri, 10 Nov
 2023 10:56:14 -0800 (PST)
Date:   Fri, 10 Nov 2023 10:56:14 -0800
In-Reply-To: <0000000000007d025d05d7aecc00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb9ac40609d0df71@google.com>
Subject: Re: [syzbot] 
From:   syzbot <syzbot+7295389ef2000630244b@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: yuran.pereira@hotmail.com

#syz test: https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
