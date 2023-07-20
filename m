Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614D275AD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGTLr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGTLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:47:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F604189
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:47:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-262e3c597b9so410423a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689853643; x=1690458443;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCYsqkS4rayXce76GOIyhRVOeXdcebP35m1e+mIKBEE=;
        b=Qn+DGoGO/uq12hb1soVkUVm9T2ISvFG5Fw/DnfhE8cZ6wyT337FFLi0ltBOH3wVpU5
         yLz+U9zgPadZmbiy3Cu6CX5QDYwRwPDw1Cb4yBPtCEkosVqSCxeQe0tK65/JGsII4XxE
         yfpNLKPGTB8ibJqziawQ9q41/cjg5JYR7MHHVlBChV4Ru60qKu94p3loyDB2QcwZBpjp
         G6lRyn7BBqB1U49f/iIoj8RGj+rmu40wccx0MkfMI6xxHuO/QWWZKb9YyW93lFInW2HO
         KYW5p3NVcqKeQqZuqnxDaEGvxuFm5O3m9RQN++RIIopeFIfWEA9p+eYuPw6eKyer/A5q
         dy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853643; x=1690458443;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCYsqkS4rayXce76GOIyhRVOeXdcebP35m1e+mIKBEE=;
        b=W/bbw9TddITgDKADTEvMr2MmXQBSZ0VUBDFz8H4aiFHVkx3XysflR+KeSxGKTAAy5B
         2WUj0m2Vx52jDeVwoOW+ab4y4RucVvdLNhXZaih3CssQ6jBT+07iZIFkSvsyAWvbNtw5
         VaoJFNOW6sw1JtdoHpG13M5JpMQiJv72mRYMzQx3QYkkfX6xHEqqKNfw0hpBsmjLx+ny
         k+jGTar630dTLwhQqMsNAO5tchDN6+PKqUHrc0ezmrzm+hdoJJKgx0oore0XxF9UDDo7
         8dCQmenNbMHP1ZbE/RuExXMePkl/KtBRRIQYnQ6aje6gJVKRB7cluZz7gqYhfpfpaQQ+
         c9Bg==
X-Gm-Message-State: ABy/qLbV6N9wzmY7AfFD85QDBmEDTj+pRiRQCUX7YsTkqIf9IPMmsqab
        HSDz7awNx89xC75Plh2hMbiAY2VvBxY4DMMeRAM=
X-Google-Smtp-Source: APBJJlHTaz1n3EBLnSOFNHQpuqiVOAMD85i/cPNbhCe0dUXnO28Fhf5Wo29sYDRynmCh0KJpOqRza1VnAGGHw/eBFLE=
X-Received: by 2002:a17:90a:4fa1:b0:263:30d6:dca with SMTP id
 q30-20020a17090a4fa100b0026330d60dcamr1666169pjh.29.1689853643471; Thu, 20
 Jul 2023 04:47:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e111:b0:4da:1abe:a260 with HTTP; Thu, 20 Jul 2023
 04:47:22 -0700 (PDT)
Reply-To: clementkwkhsbc@financier.com
From:   Clement Kwok <clementkwok998@gmail.com>
Date:   Thu, 20 Jul 2023 12:47:22 +0100
Message-ID: <CAArzz+G9mwHPf=m4QBg3KeikXczkL44h-1vrCB1h-m=bzUsOow@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_REPLYTO,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:1034 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_REPLYTO Reply-To username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [clementkwok998[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [clementkwok998[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
*I have a business proposal for you*

*Kindly get back to me for details*

*Regard*
