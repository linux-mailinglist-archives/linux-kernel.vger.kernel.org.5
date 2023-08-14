Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11A077AF59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjHNCAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjHNCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:00:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FDE6E;
        Sun, 13 Aug 2023 19:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944CB62872;
        Mon, 14 Aug 2023 02:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9A6C433C9;
        Mon, 14 Aug 2023 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691978400;
        bh=gOULuCJoXc3jPRCnRkmOEt2bSB9ASWO+W6Oj++T4tGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwXi0nn1/d0kt4PKlsBX09qdJo2cQAhbxMqbM/s3kYfJy3Eg2pvJA6gpxgOTWqs/6
         otlpnrnaYzkw5KzKJNTp9ACLhOaraEJ0tw+aHDtsNVUAnXg5g6NBn9dcM6FOx9TN8k
         LUeYooujb4efgNn2PiEWl0POGXEdHLX+cJe8uRU1+vUFQQ1VUdHcBD29hScPI8m4Zm
         zfoiLxlBh8/aAxZcjHbDw9gCSj/tPZTHYpeHWP1Luva+naPJCKbTZlA59x/2r1nIJ+
         p/Om5DmYU9Ec73aYPXPQz7NvdzdbLaodIrxI3+k44espqliQyw3ZNnmgOtJt1pI2JN
         1DZlmUc80wZcw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: Re: (subset) [PATCH v3 1/1] dt-bindings: firmware: qcom: scm: Updating VMID list
Date:   Sun, 13 Aug 2023 19:02:43 -0700
Message-ID: <169197856189.2338511.201612329421139821.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230403204455.6758-1-quic_gokukris@quicinc.com>
References: <20230403204455.6758-1-quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 13:44:55 -0700, Gokul krishna Krishnakumar wrote:
> Adding the full list of VMID's, which are used by different clients to
> pass to the secure world.
> 
> 

Applied, thanks!

[1/1] dt-bindings: firmware: qcom: scm: Updating VMID list
      commit: f9eac7e0298ff9df9ae10a579a620d07453845d4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
