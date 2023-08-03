Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08E76E70C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjHCLhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjHCLhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:37:03 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0328273B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:36:52 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5844bb9923eso9505317b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691062611; x=1691667411;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXP8FYYJAC4Q2XI+kFV6QwVSCXrjbDPFVJPQlyfT1x0=;
        b=NPfFW+6b7+4FBTsw8N3aBSn3PUXTPa/fjXbHcvzmfXItVkoMiDpI524b5XQtijgEhr
         vWp5zipylZ+516bkbJcxP302dyWPexyi8P2sKjdAZgAScnsgDQc0AXgPtZ+/sX+LAxJG
         B5FnRmLcboYfvlkJsIAnOLSl3Z3LPAuFD0bcqsuIYqeZ5FnQ7Q4udpD/YX05+OfvlTtl
         ZE0r9D7mnv9BwmQX9u8rNiqB2Up4+MCInIVh1MLDfjY7GrywtuDWzjJwb/BzDab0/fz4
         LIy7gAn+G2hpiOKXt9okTtRBPoHfOxxu90iSfWpYFUV+qZ1TF8hyufEPz3U7gyxY3pbJ
         E4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691062611; x=1691667411;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXP8FYYJAC4Q2XI+kFV6QwVSCXrjbDPFVJPQlyfT1x0=;
        b=R0tFqqYndJJlGtQ8yzMd4dtsZRsZe+jvAFTwNuWdesLD1niBGFiXq7qw4bh9WD/5Pt
         I9KFKIcjvechOgDgewVo0tkt1G88+15EA2syEb7OGnQqTd85EB5d+izRlE6XhdE0qF8j
         3KjjHBPtmOZQqbO8wSg0RWehwG1mOq8DBto6efu2kbfywmtUsmiEKJP+wuuxSK0PpRJd
         xu/4D1njYRz+cIbvoSFGMw74cy2j0LVU0u4Stg+YNDNoNuwFTFZoXXRpoxF4MmJChgAm
         P8dgshJKrTCmCNCuO3CE9HiUXUwFeeEJYSjYZVnKpCm/UG3npl1lQ7++MUsRTQ4avmQF
         7ypA==
X-Gm-Message-State: ABy/qLbR2INrXPnaC+/k6yoRMQ9ObRoaEhLfCl/1ACPBXKOgNNZiZUci
        rYLg4/DyeKWTua+KjdXtoblvfyvxcByHLPmyMMY=
X-Google-Smtp-Source: APBJJlEbE6Ir1HfjArGUFUZZYE6GZknkC33/7XADh1wOushLnTiVdDXRSttxAH1HmcSjvheVVo8KX/H9eCW6fo679bc=
X-Received: by 2002:a25:dc89:0:b0:d12:ab1:d88a with SMTP id
 y131-20020a25dc89000000b00d120ab1d88amr21258666ybe.40.1691062611361; Thu, 03
 Aug 2023 04:36:51 -0700 (PDT)
MIME-Version: 1.0
Sender: okeosazze@gmail.com
Received: by 2002:a05:7011:a196:b0:36a:d651:3516 with HTTP; Thu, 3 Aug 2023
 04:36:51 -0700 (PDT)
From:   aisha <aishagaddafi12345600@gmail.com>
Date:   Thu, 3 Aug 2023 03:36:51 -0800
X-Google-Sender-Auth: FPkskNAhiDoEIyYs0v4J3_SKtUs
Message-ID: <CAGz+XHf7qALT3PKxSs+sdTbtJigafYCpVU=nTr3ttFgftmd0qw@mail.gmail.com>
Subject: investment proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:1130 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9999]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9999]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [okeosazze[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.6 MILLION_USD BODY: Talks about millions of dollars
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear partner

May i use  this medium to open a mutual  communication wi you  seeking
your  acceptance towards investing in your country under  your  management as
my  partner, My name is Aisha Gaddafi  and presently  living in Oman,i am a
Widow and single Mother with  three Children, the only biological Daughter
of late Libyan President (Late Colonel  Muammar Gaddafi) and presently I am
under political asylum protection by the Omani Government.

 I  have funds worth "Twenty  Seven  Million Five Hundred  Thousand  United
State Dollars" $27.500. 000.00 US  Dollars   which I want to  entrust  to you
for investment projects in  your  country.  If you are  willing to  handle this
project on my behalf, kindly  reply  urgent to  enable  me  provide  you  more
details to start the   transfer  process, I  shall  appreciate  your  urgent
response

Yours  Sincerly,
Mrs,  Aisha  Gaddafi,
