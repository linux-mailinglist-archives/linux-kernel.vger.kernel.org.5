Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4407576CF64
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjHBOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjHBOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:00:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E662114
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:00:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-54290603887so4282621a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690984820; x=1691589620;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWu78CyIRi+I6jQezlGgcdcqqfSvnjtnlx/cnoDJEBU=;
        b=j7PtBattAMJcVlTIZSik7K9WyHYO7kBuUDSifXrXNIl1oasWxi6zpqyS/cROQk/zBS
         LOGhG3okFPZ3G6ADgxVmhBlcmRhDspHD3r0yc0+fQVotKwt5JtfIpgqoPfXalqF6UAWW
         ABye3gjY5WHF8hadsYrLqhRuRpcp73c7WH5kf3FLc0kYSzgKV9BwwGiDFgJOZlJF9V7d
         xwroWfJ2sZ/MKtWoCC5zfKqzhtQbZN0wZB2vCMy6464f6bltj0DRik90daatGBp8+1Uw
         sJhQfTg/VLdPHWf1pxxWqpd1BOZ+OdK9NyAojdopWTg11rKXszrUHruvsSb3gDsL8vqC
         yFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690984820; x=1691589620;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWu78CyIRi+I6jQezlGgcdcqqfSvnjtnlx/cnoDJEBU=;
        b=MKi+N0acLdw/lh6Kp0EsZrRMoKuOD2S4kCX94fxxNxiWnaknpJmH4+UsCsu7zsRTVX
         NGIoDkHsrT61RaexDTeRLJ/cBhDvYMIRWTH6Q2SQ/RvlXsCtQGj5XHbMBo0ttJbQt/y5
         7b7WtR9Yyw0WnEdbSOln+3Giyn4TmxsNOpyDpDnvFeqeKVVBAEsWgkqKQGmyoqewFJv4
         JaNai6M8d3Zem3ebj7UgGmTdKCUa8CAlbYCgR66RimD/4nov7kwvAKtaA4wIZJaCMXWv
         nYObwNP2ceyINwESpDHTRmYO1yxPKnZD1rSuCnK40K4hj5XWpDzPDaa/Ln0O8eUM/RbR
         I92g==
X-Gm-Message-State: ABy/qLbxYaI0gnQKC46lZW62AfgAE252Jf87MDxbE8oLhd4GX9F8J1fr
        5AjmG+/FORdHJGFKkILg+A2I5gEAcl557zBg/p0=
X-Google-Smtp-Source: APBJJlHUKfSAmMcU2lFHRnZSGmVlhtExiiwqgWpyM62zbZmr417EEDIY9Yc4e4TrhkdgjuVzUau9R49zbDeynuf52RY=
X-Received: by 2002:a17:90a:a58d:b0:263:f7ce:335e with SMTP id
 b13-20020a17090aa58d00b00263f7ce335emr13576114pjq.43.1690984819995; Wed, 02
 Aug 2023 07:00:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:c592:b0:4d9:93ea:8cf4 with HTTP; Wed, 2 Aug 2023
 07:00:19 -0700 (PDT)
Reply-To: p8731577@gmail.com
From:   "Mr. Philip  Edward" <kj4487936@gmail.com>
Date:   Wed, 2 Aug 2023 07:00:19 -0700
Message-ID: <CADaUBnrvC_wS23xP0S0br+Yw83-z08ZciJ0LvVB_0S2eMcPQgw@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Friend

I am Mr. Philip  Edward, I am 53 years, from USA Please forgive me for
stressing you with my predicaments and am sorry to approach you
through this media  because it serves the
fastest means of communication

I came across your E-mail from my personal search and I decided to
contact you believing you will be honest to handle this transfer
proposal

Please let me know immediately if you can handle this transfer. I will
appreciate your utmost confidentiality as I wait for your reply for
more details.

Best Regards

Philip  Edward
