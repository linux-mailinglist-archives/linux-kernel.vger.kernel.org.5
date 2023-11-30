Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121287FE998
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjK3HTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjK3HTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:19:49 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D8510D1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:19:55 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6cddc59e731so574789b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701328795; x=1701933595; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97KetFRbROfrUIuIRy6P4CZMyWy5AFFssR3Tkh7WV80=;
        b=MwRocG/fL8m/b5eWM298IZBQK2t8sR0ZF6fHxo2V4D2kjzSdYyHwGCKdNfocbdyZEp
         jMMLpIjiN7EbPSQPnxiiQJuCFycPwH99JeoJfRDuwfY3q+n8itT0lA17gufPe+NAtcJf
         +qUeFC3iDRm66EBgV7znmtQ2KZdVP9vcZPjP5nQRI5AJi+NbAdmNcQwSJj1lgRN7PAe4
         ZUfAicWvrw9++4aVlZAf4TTV0mgWwDaEzgj3hh7/wuXWvlfuwGZKPIyP8RpegsCOQP/f
         dUTGlkTDs/mrOGzb/PMwwZ9Vs+XgtpQPdfRsscN/TKrTRwaiJSiAKQVh8tt8aSxV2Kl9
         P4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701328795; x=1701933595;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97KetFRbROfrUIuIRy6P4CZMyWy5AFFssR3Tkh7WV80=;
        b=KmeYLFC7r66EnP6KHD24x5nppCv2EFk5uo2raNnUvc623RlgWYCAHM36OhXHK/CJc8
         vqaXFYnpsPvIq2oHykRd/NwaYSAfy6dzFNFwDYLNZmzgvoqYJ05Wz+Sb2JSIFer3JG0q
         arWWJF8mRrWwOchtmocrk7lui+wqpbHaCtZhQRyq6uWa00FGH8q5ZQvb70tykrx3oXGI
         GtN5X2fP5HsKNQfJ1vBPB6ZKDycliefRKofJgR2vIwM86vY6gjLeN2XivbK9Q0srhgZ/
         PU3eC69w8TuGen6gBXKfL83pwDpZg+CsujafCXxHOiL4whIbTrs0ujNogOKBtYdUO2U/
         Hz9g==
X-Gm-Message-State: AOJu0YyVn4c9Y6e61mS1Q6lD9DGTOcs0DWEx4S4HF1P1VVokl5GQa/oY
        hKjtTTUgMi5jgeSZTUdlPwTbG59hBYynsBFjpwo=
X-Google-Smtp-Source: AGHT+IHvVWxz7lEs8Rm3Q1LQChg5Rnyu6swYDRbLpeEoIDioHqkx8xFhp1Vf+m8rEE2UVOKGbnkNlBib2RYv6sBjfw4=
X-Received: by 2002:a05:6a21:788e:b0:18a:fbd1:8e6d with SMTP id
 bf14-20020a056a21788e00b0018afbd18e6dmr22193576pzc.27.1701328794297; Wed, 29
 Nov 2023 23:19:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:672a:b0:6d:d49a:a7fe with HTTP; Wed, 29 Nov 2023
 23:19:53 -0800 (PST)
Reply-To: operationmanagermike@gmail.com
From:   mike <okiemijueh@gmail.com>
Date:   Thu, 30 Nov 2023 08:19:53 +0100
Message-ID: <CAFEvTx0jqDvW=Ka7x0BO1NroEA-f-a9xEh+px0QcK_cLZOeY7w@mail.gmail.com>
Subject: product order
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is Mr. Mike, let us know if you can export to Germany? Pls confirm
because we want to purchase from you.

Looking forward to receiving your reply as soon as possible.


Best Regards
Mike

Operation Manager
Covestro & co investment
Email:operationmanagermike@gmail.com
Mobile:+49-1325457732
Address:Leipziger Str. 48A, 60488 Frankfurt am Main, Germany
