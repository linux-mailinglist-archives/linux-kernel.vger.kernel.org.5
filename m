Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA2758607
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGRUXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGRUXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:23:15 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3741992
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:23:14 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-cea6b429d05so1147345276.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689711794; x=1692303794;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qw5CFaI3X+N6BThRXsBy//48rBDBwT2177YsdbP2ly0=;
        b=FZL81m21Q9xAkone+3OQV7LM+rdNKwR5RN0TvybT3y41ihLx8JieZUO9M4Ppd3xh0K
         xji+MZZ5IhChh9kKzKjra5Wboh/qIPlPzq9wQILkj33/uoOMk6ggGSvZNaJTDgZj/rJs
         KjCXynE4ddzacBKpZ4Cv/Jw85M9z++urogdmL6V+wMyK53GulVWY5YHp32ru7jtJszPj
         9x7xk7PJY4gFB2jVN2oiyXGNaNu5kh5gHU7xZEH/RUSpLSe/uTcLjGW1bSDqUP40Ufir
         H+XY5Sf5Itt25NW+SkfMwpmdbpxm1P5BKIstFZlztEgU0Hfb0I/oJehSHgItOJK7q24+
         neDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689711794; x=1692303794;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qw5CFaI3X+N6BThRXsBy//48rBDBwT2177YsdbP2ly0=;
        b=ZpCjAsPxosON0X+NG+JMcvjKH6bBVaYOOEa/prcK6BjwDRxyoBY5Iu1APBnb1HqZOD
         hCmRLLo+FRC6DkmAkJOUNp+WsfUVcouKvFAHPcGCWUusDkOVAxvxnEtWamJJpEilbylZ
         HUUfzIAKlLOiS+geIaZNogvP+VifySxQ/RB9ZHH75GEPfTd9m2kaTzBmQL9zY05pQSyx
         Rcfe6WU5u+oXzxm2KSWp4Y+eaUU8Hd0/w4z7KrW2a8omwvY/MOXtdUD7B1P0g1dOBXpu
         b0mq+4uYbEReckBGxpsloh4tj3sB1N2TmJfXLtO28rMUE2Jo/fL0uk2oybOsdkP3bwTH
         24Ww==
X-Gm-Message-State: ABy/qLal5kR4d9oCgmaJuCl9sCFjaA+ib/sg4vhV9XiYEtqXeBLwmU7s
        DtyqoZT8xvhZ9iLsSj+tCELBhYYiIelxmFeK8ZU=
X-Google-Smtp-Source: APBJJlHvAUo0qXccr8ZRg5DFZh/pinnXhadK3OsXD3YirCzeWY/d7B7N1bOZiKipnJuvSQJ88+hGa2yr5f+cPkpQ+30=
X-Received: by 2002:a25:fc10:0:b0:cf0:8fde:c325 with SMTP id
 v16-20020a25fc10000000b00cf08fdec325mr930925ybd.4.1689711793897; Tue, 18 Jul
 2023 13:23:13 -0700 (PDT)
MIME-Version: 1.0
From:   Amelia Lucas <datalistsdask@gmail.com>
Date:   Tue, 18 Jul 2023 15:22:40 -0500
Message-ID: <CADvfT5YGOUV+rAoCMqt5cuxi-PkdYaNsOkQVZEa+DYvrFYR+9A@mail.gmail.com>
Subject: RE: PACK EXPO Shows Attendees Email List- 2023
To:     Amelia Lucas <datalistsdask@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PACK EXPO Shows 2023

Would you be interested in acquiring PACK EXPO Shows Attendees Email List?

EVENTS                           Contacts     Costs:
PACK EXPO West             40,368        $2,289
PACK EXPO Las Vegas    17,367        $1,626
PACK EXPO East              18,379        $1,518

Number of Contacts: 76,382 Discounted Costs: $3,299

Interested? Email me back; I would love to provide more information on the list.

[Amelia Lucas]
