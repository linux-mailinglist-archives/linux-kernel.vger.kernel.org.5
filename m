Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5543A7DC17A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjJ3VBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjJ3VA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:00:58 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05CFF7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:00:56 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1eb7a8d9610so675673fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698699656; x=1699304456; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P8m8EAbGJbUxe5B9fBXpOTBojQ9A3raNvAoswxRtY9Q=;
        b=aoyiCgUcQN8c/5sVQTRxOhI2mf0uK+Sie1DmvB78iBN2wo96pVIfFeljIjLNfg/tPW
         5d1VsshSJ/SBYzNEIuZr2DY4iK3pAp21GQcBLdpzbbBKjYAS47O0r3GEZV89bCSrOm8x
         d2mg+KpxGkj42Q8Zj/Ob5+JwKYhGuCOIcOak5mHQx1WiN/rVNUOiN5mN0dQxrkKgA1Cf
         IVKbkg2jofArrOZQaG9AXLfc1TwmzSCGKrAIaNwwiugwWP3qAynXDZenwmJr0xtwyNzT
         5FC77wIe2OKqV/W9ZVsb983qx260W12487Yp0lYgMki4A8HYr4fLA1CSMz3tmfB3Ebnz
         wITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699656; x=1699304456;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8m8EAbGJbUxe5B9fBXpOTBojQ9A3raNvAoswxRtY9Q=;
        b=GPbu3kfSwWuhxLy7T24SsBc93VD2szKaK1jWb/Yy6iMzUCx4dZV6wIt82vE2V5Gvlg
         S9TdwysRHvkOiEXHXl5n9oPVEwdkfNAvOk2msSD4x/PZebed/XWSqkxjOG/R1tim6Dgt
         TVIHBX555GhgNFrOtSpsNcIr7T6+ELnfdpFcGHdLLRyYOpAfL41nmroHwWXw/vEhV5Av
         IO7kUdWmc3BrL7wU/j/1u4X1rnr5oAySTGQeYZbhqViUKdu8OBrMwLWJZ83vcogrgZxF
         FaKWzT6VOL6gJtD2473SXK29SEPHbayB5C7X1IrHWb1x2fCY9ngQpMqNEXU8miFYqThE
         90Tw==
X-Gm-Message-State: AOJu0YxQq+ee6cevJcvjp8clyAyJwkuEVvNIB+qrkE3Rwo4rd4Z1Lfwj
        eY9m/5TtOuvXMnvbbi/PfIAEYkQKmXyCikEDAxE=
X-Google-Smtp-Source: AGHT+IGik9l8JnL2h7xGT4i9fKk/5AFYblPH/eXoagbBRtKIpX5R7mNmQGNMicsortoCX8tngKlkxWNCti8kswgw1U0=
X-Received: by 2002:a05:6870:9c87:b0:1e9:8a7e:5893 with SMTP id
 pq7-20020a0568709c8700b001e98a7e5893mr11458603oab.5.1698699655902; Mon, 30
 Oct 2023 14:00:55 -0700 (PDT)
MIME-Version: 1.0
From:   olivia taylor <onetapdatalist@gmail.com>
Date:   Mon, 30 Oct 2023 16:00:41 -0500
Message-ID: <CACxKAZ=6nN=DzLgijYc6AWTbY1tVZ-W8WrnMiHqiKWhh=8dk_A@mail.gmail.com>
Subject: RE: AWS re:Invent Attendees List- 2023
To:     olivia taylor <onetapdatalist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring the AWS re:Invent Attendees Data
List for 2023?

The list includes: company or organization name, first name, last
name, full name, contact job title, verified email address, website
URL, mailing address, phone number, industry, and many more.

Number of Contacts: 50,487
Cost: $1,989

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Olivia
Marketing Coordinator
