Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157FB768408
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjG3Gfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3Gfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 02:35:39 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5AB19B2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 23:35:38 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-565e4741723so481151eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690698937; x=1691303737;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=WyheoXtMfTcS7C7OclQZZh2gRdvyNNfQIKBmEWZCt8PMXVmVr8gastYlCMJIafS063
         5XSy97M6CskW3raz19O0tGRLDgOmzFSJ4PkKGsUd+4va/SYFpb8L+8ChTefPqTOw1aUx
         IlFN2LQmTi48xkPwKeNw77GJ9qs4xEjyBaIp/A+8fFgL6FpmdSb8JpsGIh0ehdZwbQIm
         w1fpdESm/9XKNfh0tTpZu71tiPuMyhct3z0kLVXW38QCul79F+Ler8YZMx0NMaPgys+3
         PSLwJz6h0ZrYn+MTHIMmrHzAonlIAJU20fbjkPkFooyaLQlzvlfktA9Re18rOhIH8twX
         OcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690698937; x=1691303737;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=XUEncUawWcX2pWIO6keRRDa34rEtJoBA/CKqL2urxLDxuo7R6CV4LBiTU/i54lSgOy
         JGgKP0VvjZWkFOi5FiMcviUXiAeUUJBO+ooMBveLEUoy1JZjnRaowL9EkTKdFm0snnii
         nclmNJ2RA7NN4QGdAUR/wd26w6IuTYdz63fGC5Y4ZlSV+t+kK4FkVgtwAdBcfnfEqwtv
         FZuqaYDLMbq/TsKkP1FvehIixy56kyETY0z55pKBfAC5WQd3EfkUuXGSNvMCPKngQ1Ar
         J9RvH56ioAP+Ok6gvM49eTgTF8QHFxNFZA5/rlG5F8kb/Y7Mq9pD1PU/NuEmVnncPis1
         WWmQ==
X-Gm-Message-State: ABy/qLbME+oysHu0NgPu5Fm6f8fUwF4psZ9Cg9fgoVqnwbRa88WIP9+K
        1eauLZSQTrmnPlBo1uSvHjdDPSIZlDJ/1nn+cyE=
X-Google-Smtp-Source: APBJJlGmZHfbI/HebzHbB/vRXdq7nurWADyYAcGoB1Nn0vp9nDAveVGO/xiPz02MJ4dBd+dvge/l2zHhjhyAshJGa0g=
X-Received: by 2002:a05:6820:2108:b0:56c:5e21:c72d with SMTP id
 cd8-20020a056820210800b0056c5e21c72dmr2981597oob.1.1690698937164; Sat, 29 Jul
 2023 23:35:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:a084:b0:11a:67b4:a778 with HTTP; Sat, 29 Jul 2023
 23:35:36 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <khanadbul01@gmail.com>
Date:   Sat, 29 Jul 2023 23:35:36 -0700
Message-ID: <CALr78wU9U4MNhEj2CM1rTBe6C9N9=ME8A89PaxrwwA4jgxRM3Q@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c31 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [khanadbul01[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [khanadbul01[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
