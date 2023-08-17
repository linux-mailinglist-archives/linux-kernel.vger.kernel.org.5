Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF8C77F2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349275AbjHQJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349263AbjHQJFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5402F198C;
        Thu, 17 Aug 2023 02:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD3686405F;
        Thu, 17 Aug 2023 09:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0D7C433C8;
        Thu, 17 Aug 2023 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692263129;
        bh=+Jnj8GJFBamTvK5cxmX7TmNo57+sMPD4uUEdg61dzTQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=TbccUY98YPiu6LTC1u10UlGAGP6E18LD7+ODDVe7iFQgYngvGor9S5/AnPbVjrbvS
         gQDa5wTA8wV14clW4IhsVmLeBVeDDsLeDVb7rM6hAXjfcjfSwFljQWa0fS7ESIO2Jf
         En0Za8nxsXl9P6q/+o5bBse72h2QSwsTsLWcBqer7URTpx4+QAKAOFYfk9pP00B8Ja
         NidjmKh3167D2UMdmEAcPOvgRqz3fp2JEsVitjpAr/sz3XOk7hUqs3PV8U3dOtcVZ7
         JEYb7kG1IsvY4dC8DjpcA2HpmJ+Bl8h1EKG4TlY2mZ3lV/jZf72d7EBxbqkzoQwbBI
         D4pYdqRN/IcIQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20230728102539.266085-1-varshini.rajendran@microchip.com>
References: <20230728102539.266085-1-varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v3 16/50] dt-bindings: atmel-matrix: add
 microchip,sam9x7-matrix
Message-Id: <169226312676.929379.5981372625277712422.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 10:05:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 15:55:39 +0530, Varshini Rajendran wrote:
> Add microchip,sam9x7-matrix to DT bindings documentation.
> 
> 

Applied, thanks!

[16/50] dt-bindings: atmel-matrix: add microchip,sam9x7-matrix
        commit: 39e82a0774739ce4bde4adf8c4997bcc4541816a

--
Lee Jones [李琼斯]

