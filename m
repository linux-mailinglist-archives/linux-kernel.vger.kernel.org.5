Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F74E7E2AAF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjKFRJw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 12:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKFRJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:09:51 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59A125
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:09:48 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1ea1c5774d2so5928145fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 09:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699290588; x=1699895388;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZXPgZsRDhHVKtTCIzWfu9JbsH4viWkWG1onDBkCkdI=;
        b=WyVIstDnDk9A+xenDpI8aTuMb70bT/5xsgSs8WMTEbxhyR8t+Jxgo5wi1lTjUB87FN
         UTAOAvrAz9+qqnkG56OvsU+fUpxlZeP1wpthtEpoTpMHbvFERHJ+CfUmyqpdE0utBqI+
         9VPl7Fkoz9SvkaFQydMUDHEBTIOeSuZ/Pn9NPKNaz2ddcufS7uweojXeMeLo5YMecZme
         0+aXeP8lGmHxgSjmsO3WvRrAWPeweocklghJgY0fLgacDcaG014Xv0/4S9PoijHudt4R
         pyfeQ6w3/TUibnHck1KYiU3ndO5YV4VAhBaFEoI0MIny/m6/FoHoaq3oJ7Duc95mJ9UV
         wa0Q==
X-Gm-Message-State: AOJu0Yzo+n1CyO4E6e5RgrxmI4nz0F6Vs2dBmbjqlpTlG9HmDWezFd60
        pfl7JNQd3395FQuYqbOogDsTMgH0TAPO+1EgynTWuNtP0RcZ6HY=
X-Google-Smtp-Source: AGHT+IFPdRFHJKzXmo1hKU2Eqo9XZAWCV0rf/paYZYIibZOymE0ZBzPxFl18961dNnnJ7zXsvWbD0wTilhH9BZWwSAx2X/xAyBZY
MIME-Version: 1.0
X-Received: by 2002:a05:6870:794:b0:1e9:b451:bae6 with SMTP id
 en20-20020a056870079400b001e9b451bae6mr122863oab.1.1699290588099; Mon, 06 Nov
 2023 09:09:48 -0800 (PST)
Date:   Mon, 06 Nov 2023 09:09:48 -0800
In-Reply-To: <0000000000007ad39e05bcb1a38d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfbea706097eeb77@google.com>
Subject: Re: [syzbot] syz-test
From:   syzbot <syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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
linux-kernel@vger.kernel.org.

***

Subject: syz-test
Author: jose.pekkarinen@foxhound.fi


#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
5a6a09e97199d6600d31383055f9d43fbbcbe86f

     José Pekkarinen.
