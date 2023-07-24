Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3875F67C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGXMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGXMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:40:16 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1863E51
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:40:15 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4470837ff8aso1063224137.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690202415; x=1690807215;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wnf9hS4rWgJA0Ixb+vooCZbPaPY6ETfoy/05xXuPeDU=;
        b=guu1euNaBUTcjSH2W7t2CZ1/0GDyCu6U6f+VJV9UqxSITRxfpQrc4/HUcLQFkGSpSe
         EcCVwdXUJ6x2eynrWmev/Ro7vUQvdG84u8/oc/2VV7jPBCSkgGfYxJwiFpi4MreFrcQa
         Y8ojqZQqpLEDBaAgz1sbMMvJJlByubJlLpk7WwUMgSCQNGeMCIiG/1iDJm+ZcRi8A9fO
         c/2ZaT+jE9EQ+Ykk0ftH9m9nMgosqhYNWB0wk7u6vEiZATKzGeTHTIuC+SUPqICRV09I
         TtdWzpgzdF6N2x1lS6YPdtP/GO7yUKi9wpKuxKhFfJywdFVcg2NfXIyL2POrLev6YEuQ
         L/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690202415; x=1690807215;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnf9hS4rWgJA0Ixb+vooCZbPaPY6ETfoy/05xXuPeDU=;
        b=lO1n92tjK5re7H2UixNzw/wwjLgklVuxWPEbEv2cbp12mM7DzAes5ytAQh6OrTIi8W
         ZwkpB0YUl2xZA5/aQA7XUSyPvT4+Q9lE/4ojP1I4BFI2RmUDKrncAesxyVtk8jiyOK2C
         TvCQt5bb7PsMEEV5H2yu7+NP2Ip9xLkrgSDh434ZG0r9ZaaRtDB4v0VhCSu878buEgzP
         9vt6j2lqsree9RO97wxFadyRVF3A3Y5vXgrPKjEDX8oLrtG91HcS2+frdPKsWlF/MRE3
         KZUc3//ada+pILvq2sy3rUgAb/bfXVlBnPHMrAOsK6ftWtDWc7XuyXGCwjEudroDOjFS
         3VHg==
X-Gm-Message-State: ABy/qLb23UgZUz+yotIEMDx0sw7HmSpCimQZRdc/yx12tW+frLqWIwXR
        jxlRrV7Vw1wmNyKrnGZ3pQXEf7TpRsAtXSLKOSk=
X-Google-Smtp-Source: APBJJlEgb05iqa0uWmatYtPrGpTnNk+qMDu/UIwurUjI8ofdvH8dW4MWv/Qgo2juzlnYXythPVzjMq9lGn/Ik8U+8Rc=
X-Received: by 2002:a67:bc16:0:b0:43b:3cab:23a8 with SMTP id
 t22-20020a67bc16000000b0043b3cab23a8mr2597768vsn.20.1690202414659; Mon, 24
 Jul 2023 05:40:14 -0700 (PDT)
MIME-Version: 1.0
Sender: dinamckennahowley@gmail.com
Received: by 2002:a0c:f544:0:b0:626:402b:1de1 with HTTP; Mon, 24 Jul 2023
 05:40:14 -0700 (PDT)
From:   Margaret Henry <margarethenry642@gmail.com>
Date:   Mon, 24 Jul 2023 05:40:14 -0700
X-Google-Sender-Auth: 8yLihb1m4aRFSPqcY4irUHw9ORs
Message-ID: <CAHL3TZKTGgCd7oTML7Qv1ZSwrRHUEO0XQKzgeQyVE7MvzZojiQ@mail.gmail.com>
Subject: Hello.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear did you receive my last massage
